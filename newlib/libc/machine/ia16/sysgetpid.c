/*
 * Copyright (c) 2022 TK Chia
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
 * Discard the default platform-independent definition of getpid (), which
 * calls _getpid_r (.).  Instead, define _getpid_r (.) in terms of getpid
 * (), which is expected to be more efficient...
 */

#include <reent.h>
#include <unistd.h>

pid_t
_getpid_r (struct _reent *r)
{
  return getpid ();
}
