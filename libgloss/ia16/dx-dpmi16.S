/*
 * Copyright (c) 2023 TK Chia
 *
 * The authors hereby grant permission to use, copy, modify, distribute,
 * and license this software and its documentation for any purpose, provided
 * that existing copyright notices are retained in all copies and that this
 * notice is included verbatim in any distributions. No written agreement,
 * license, or royalty fee is required for any of the authorized uses.
 * Modifications to this software may be copyrighted by their authors
 * and need not follow the licensing terms described here, provided that
 * the new terms are clearly indicated on the first page of each file where
 * they apply.
 */

#include <sys/syslimits.h>
#include "call-cvt.h"

	.arch	i386
	.code16

/*
 * For programs that use a DOS extender, check whether we can (or should)
 * clear the high halves of certain 32-bit registers when calling certain
 * DPMI functions.  This is necessary if we are running 16-bit code but as
 * a 32-bit DPMI application --- which may happen if the program is compiled
 * in "dual mode" (-mdosx32).
 */

#define MIN_TB_SZ	(2 * PATH_MAX)

	TEXT_ (dx_dpmi16.S.LIBGLOSS)

.Lctor_dpmi16:
	movw	$0x0400, %ax
	int	$0x31
	cmpb	$2,	%cl
	jz	.done
	movw	$.Ldpmi16_386, __dosx_dpmi16_shim
.done:
	RET_ (0)

.Ldpmi16_286:
	int	$0x31
	RET_ (0)

.Ldpmi16_386:
	pushl	%edi
	popw	%di
	movzwl	%di,	%edi
	int	$0x31
	pushw	%di
	popl	%edi
	RET_ (0)

	.section .data, "aw"

	.balign	2
	.global	__dosx_dpmi16_shim
__dosx_dpmi16_shim:
	TEXT_PTR_ (.Ldpmi16_286)

	.section .ctors.65535

	.balign	2
	TEXT_PTR_ (.Lctor_dpmi16)
