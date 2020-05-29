;;;; netcalc.lisp

(in-package #:netcalc)

(defun make-ip4 (a b c d)
  (list a b c d))

(defun prefix-len (len)
  (when (or (< len 1) (> len 32))
    (error (format nil "Invalid prefix length! The value must be between 1 and 24.~%Provided: ~a" len)))
  (let (result (idx 0))
    (loop :for i :from 1 :upto 4 :do
	 (let ((curr 0))
	   (loop :for j :from 7 :downto 0 :do
		(when (< idx len)
		  (setf curr (+ curr (expt 2 j))))
		(incf idx))
	   (push curr result)))
    (reverse result)))

(defun make-mask (&key (quad '(255 255 255 0) quad-supplied-p) (len 24 len-supplied-p))
  (if quad-supplied-p
      (validate-mask (apply #'make-ip4 quad))
      (if len-supplied-p
	  (prefix-len len))))

(defun validate-mask (m)
  (let ((prev (first m)))
    (dolist (b m)
      (when (or (> b prev) (> b 255))
	(error (format nil "Invalid mask: ~a" m)))
      (setf prev b))
    m))
