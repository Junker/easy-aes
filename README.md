# Easy-AES

Perform AES-256 (CBC) encryption/decryption compatible with OpenSSL, CryptoJS,
Gibberish AES and other libraries.

## Installation

This system can be installed from [UltraLisp](https://ultralisp.org/) like this:

```lisp
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload "easy-aes")
```

## Usage

**encrypting data:**

```lisp
(easy-aes:encrypt some-string "my-password") ; returns encypted base64 string
;; or
(easy-aes:encrypt some-vector "my-password")
;; or
(easy-aes:encrypt some-stream "my-password")
;; or
(easy-aes:encrypt some-string "my-password" :uri t) ; returns encypted base64 string suitable for URL
```

**decrypting data:**

```lisp
(easy-aes:decrypt b64-string "my-password")
;; or
(easy-aes:decrypt b64-stream "my-password")
;; or
(easy-aes:decrypt b64-url-string "my-password" :uri t)
```

**example:**

```lisp
(babel:octets-to-string (easy-aes:decrypt (easy-aes:encrypt "test123" "pass") 
                                          "pass")) 
;; => "test123"
```
