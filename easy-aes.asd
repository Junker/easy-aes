(defsystem "easy-aes"
  :version "0.1.0"
  :author "Dmitrii Kosenkov"
  :license "MIT"
  :depends-on ("cl-base64" "ironclad" "babel" "alexandria")
  :description "system for OpenSSL compatible AES encryption"
  :components ((:file "package")
               (:file "easy-aes")))
