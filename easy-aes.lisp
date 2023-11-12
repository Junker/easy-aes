(in-package #:easy-aes)

(defun md5 (data)
  (ironclad:digest-sequence 'ironclad:md5 data))

(defun concat-vectors (&rest vectors)
  (apply #'concatenate '(vector (unsigned-byte 8)) vectors))

(defmacro cypher (key iv)
  `(ironclad:make-cipher :aes
                         :mode :cbc
                         :key ,key
                         :initialization-vector ,iv))

;; PUBLIC

(defun encrypt (data pass &key uri)
  (let* ((data (etypecase data
                 ((vector (unsigned-byte 8)) data)
                 (string (string-to-octets data))
                 (stream (read-stream-content-into-byte-vector data))))
         (tail-length (- 16 (mod (length data) 16)))
         (tail (make-array tail-length  :element-type '(unsigned-byte 8) :initial-element tail-length))
         (data (concat-vectors data tail))
         (salt (ironclad:make-random-salt 8))
         (salted-pass (concat-vectors (string-to-octets pass) salt))
         (h #())
         (comp #()))
    (loop while (< (length comp) 48)
          do (progn
               (setf h (md5 (concat-vectors h salted-pass)))
               (setf comp (concat-vectors comp h))))
    (let ((key (subseq comp 0 32))
          (iv (subseq comp 32 48)))
      (usb8-array-to-base64-string (concat-vectors (string-to-octets "Salted__")
                                                   salt
                                                   (ironclad:encrypt-message (cypher key iv) data))
                                   :uri uri))))

(defun decrypt (b64 pass &key uri)
  (let* ((data (etypecase b64
                 (string (base64-string-to-usb8-array b64 :uri uri))
                 (stream (base64-stream-to-usb8-array b64 :uri uri))))
         (salt (subseq data 8 16))
         (cipher-data (subseq data 16))
         (salted-pass (concat-vectors (string-to-octets pass) salt))
         (h #())
         (comp #()))
    (dotimes (i 4)
      (setf h (md5 (concat-vectors h salted-pass)))
      (setf comp (concat-vectors comp h)))
    (let* ((key (subseq comp 0 32))
           (iv (subseq comp 32 48))
           (decrypted (ironclad:decrypt-message (cypher key iv) cipher-data))
           (tail-length (aref decrypted (1- (length decrypted)))))
      (subseq decrypted
              0 (- (length decrypted) tail-length)))))
