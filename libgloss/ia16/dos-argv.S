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

/*
 * Store a copy of the argv[] pointer for any programs or libraries that
 * may need it.  This code snippet must run at a particular point in the C
 * startup code, just before any compiler-inserted .init code fragments are
 * invoked.
 */

	.arch	i8086, nojumps
	.code16

	.section .preinit, "ax"

	movw	%ax,	__argv

	.comm	__argv, 2
