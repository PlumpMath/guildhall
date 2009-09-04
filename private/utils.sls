;;; utils.sls --- Utilities for dorodango

;; Copyright (C) 2009 Andreas Rottmann <a.rottmann@gmx.at>

;; Author: Andreas Rottmann <a.rottmann@gmx.at>

;; This program is free software, you can redistribute it and/or
;; modify it under the terms of the new-style BSD license.

;; You should have received a copy of the BSD license along with this
;; program. If not, see <http://www.debian.org/misc/bsd.license>.

;;; Commentary:

;;; Code:
#!r6rs

(library (dorodango private utils)
  (export apush
          warn
          make-fmt-log)
  (import (rnrs)
          (spells alist)
          (spells fmt)
          (spells logging))

(define (warn who message . irritants)
  (raise-continuable
    (condition (make-warning)
               (make-who-condition who)
               (make-message-condition message)
               (make-irritants-condition irritants))))

(define (apush k v vals)
  (cond ((assq k vals)
         => (lambda (entry)
              (acons k (cons v (cdr entry)) (remq entry vals))))
        (else
         (acons k (list v) vals))))

(define (make-fmt-log logger-name)
  (let ((log (make-log logger-name)))
    (lambda (level . formats)
      (log level (lambda (port)
                   (apply fmt port formats))))))

)