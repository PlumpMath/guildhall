;;; bundle.scm --- Bundle unit tests

;; Copyright (C) 2009 Andreas Rottmann <a.rottmann@gmx.at>

;; Author: Andreas Rottmann <a.rottmann@gmx.at>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
#!r6rs

(import (rnrs)
        (spells testing)
        (spells testing run-env)
        (spells pathname)
        (dorodango package)
        (dorodango bundle))


(define (symbol<? s1 s2)
  (string<? (symbol->string s1) (symbol->string s2)))


(define-test-suite bundle-tests
  "Bundles")

(define (test-bundle-contents bundle)
  (test-eqv #t (bundle? bundle))
  (test-equal '(file-conflict-foo foo)
    (list-sort symbol<? (map package-name (bundle-packages bundle)))))

(define-test-case bundle-tests open/directory ()
  (let ((bundle (open-input-bundle (pathname-join (this-directory) "bundle"))))
    (test-bundle-contents bundle)))

(define-test-case bundle-tests open/zip ()
  (let ((bundle (open-input-bundle (pathname-join (this-directory) "bundle.zip"))))
    (test-bundle-contents bundle)))

(run-test-suite bundle-tests)

;; Local Variables:
;; scheme-indent-styles: (trc-testing)
;; End: