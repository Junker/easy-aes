(defsystem "easy-aes"
  :version "0.1.0"
  :author "Dmitrii Kosenkov"
  :license "MIT"
  :depends-on ("cl-base64" "ironclad" "babel" "alexandria")
  :description "system for OpenSSL compatible AES encryption"
  :homepage "https://github.com/Junker/easy-aes"
  :source-control (:git "https://github.com/Junker/easy-aes.git")
  :components ((:file "package")
               (:file "easy-aes")))
