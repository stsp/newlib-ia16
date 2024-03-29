#include "call-cvt.h"

	.arch i8086,jumps
	.code16
	.att_syntax prefix

	TEXT_ (dos_writer.S.LIBGLOSS)
	.global		_write_r
_write_r:
	ENTER_BX_(8)
	pushw	ARG0W_BX_
#ifdef __IA16_CALLCVT_REGPARMCALL
	MOV_ARG2W_BX_CLOBBER_(%ax)
	MOV_ARG4W_BX_(%dx)
	MOV_ARG6W_BX_(%cx)
	/*
	 * int $0x21 with %ah == 0x40 and %cx == 0 will truncate or extend
	 * the file to the current position (www.ctyme.com/intr/rb-2791.htm).
	 *
	 * This differs from POSIX semantics for write (fd, buf, 0), which
	 * say that the function should only detect errors or do nothing.
	 *
	 * Thus we need to check for the write (fd, buf, 0) case, and treat
	 * it specially.
	 */
	jcxz	.nowrite
	xchgw	%ax,	%bx
#else
	MOV_ARG6W_BX_(%cx)
	jcxz	.nowrite
	MOV_ARG4W_BX_(%dx)
	MOV_ARG2W_BX_(%bx)
#endif
	movb	$0x40,	%ah
	int	$0x21
	popw	%bx
	jnc	.noerror
	movw	%ax,	(%bx)
	sbbw	%ax,	%ax
.noerror:
	RET_(8)
.nowrite:
	popw	%bx
	xchgw	%ax,	%cx
	RET_(8)
