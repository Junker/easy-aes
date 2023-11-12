(defpackage easy-aes
  (:use #:cl #:base64)
  (:import-from #:babel
                #:string-to-octets)
  (:import-from #:alexandria
                #:read-stream-content-into-byte-vector)
  (:export #:encrypt
           #:decrypt))
