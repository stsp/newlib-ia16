/*
 * Copyright (c) 2019--2023 TK Chia
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

#include "call-cvt.h"

	.arch	i8086, jumps
	.code16

	.text
	.balign	2
	.global	__ia16_near_data_segment
__ia16_near_data_segment:
#ifndef __IA16_FEATURE_DOSX
	SEG_RELOC_ (., 9f)
#endif
	.hword	0

#ifdef __IA16_FEATURE_DOSX
.Lctor_near_data_segment:
	/* Patch the text segment the hard way...  */
	movw	$0x000a, %ax
	movw	%cs,	%bx
	int	$0x31
	jc	8f
	movw	%ax,	%ds
	movw	%ss,	__ia16_near_data_segment
	xchgw	%ax,	%bx
	pushw	%ss
	popw	%ds
	movw	$0x0001, %ax
	int	$0x31
8:
	ret

	.section .ctors.65535

	.balign	2
	.hword	.Lctor_near_data_segment
#endif

	.section .data, "aw"
9:
