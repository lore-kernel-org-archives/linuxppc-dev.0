Message-ID: <001001c32c5c$0928fb80$0700a8c0@eurostudio.local>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Tcl8.4 library
Date: Fri, 6 Jun 2003 20:47:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to All,

I'm not sure if this is the right place where to post the msg, but anyway
please forgive me if it is true.

In our development (on a 8260 custom board) We have the necessity of testing
some ISDN BRI interfaces. For such reason I'm trying to get working with the
vbox utility.
First of all I have got some trouble during cross compiling the ISDN4K
package, because It was asking for TCL library. Thus I downloaded the
package tcl8.4.3 from the Internet and after configured and ran make utility
I got the following message:

/opt/eldk/usr/bin/ppc_82xx-gcc -pipe -c -O -D__NO_STRING_INLINES -D__NO_MATH
_INLINES -DTCL_DBGX= -Wall -Wconversion -Wno-implicit-int -fPIC -I./../gener
ic -I. -fno-inline  -DHAVE_UNISTD_H=1 -DHAVE_LIMITS_H=1 -D_LARGEFILE64_SOURC
E=1 -DTCL_WIDE_INT_IS_LONG=1 -DWORDS_BIGENDIAN=1 -DHAVE_GETCWD=1 -DHAVE_OPEN
DIR=1 -DHAVE_STRSTR=1 -DHAVE_STRTOL=1 -DHAVE_STRTOLL=1 -DHAVE_STRTOULL=1 -DH
AVE_TMPNAM=1 -DHAVE_WAITPID=1 -DHAVE_UNISTD_H=1 -DHAVE_SYS_PARAM_H=1 -DHAVE_
SYS_TIME_H=1 -DTIME_WITH_SYS_TIME=1 -DHAVE_TM_ZONE=1 -DHAVE_GMTIME_R=1 -DHAV
E_LOCALTIME_R=1 -DHAVE_TM_GMTOFF=1 -DHAVE_TIMEZONE_VAR=1 -DHAVE_ST_BLKSIZE=1
 -Dstrtod=fixstrtod -DSTDC_HEADERS=1 -DHAVE_SIGNED_CHAR=1 -DHAVE_LANGINFO=1
-DPEEK_XCLOSEIM=1 -DHAVE_SYS_IOCTL_H=1        -DTCL_SHLIB_EXT=\".so\"
./../compat/strstr.c
./../compat/strstr.c: In function `strstr':
./../compat/strstr.c:67: `NULL' undeclared (first use in this function)
./../compat/strstr.c:67: (Each undeclared identifier is reported only once
./../compat/strstr.c:67: for each function it appears in.)
./../compat/strstr.c:68: warning: control reaches end of non-void function
make: *** [strstr.o] Error 1
[root@ServerCompaq unix]#

Anybody has an Idea (or some URL) on how can I compile and run the vbox for
a MPC8260?

Any help would be appreciated
Thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
