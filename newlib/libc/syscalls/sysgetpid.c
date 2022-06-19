/* connector for getpid */

#include <reent.h>
#include <unistd.h>

pid_t
_DEFUN_VOID (getpid)
{
  return _getpid_r (_REENT);
}
