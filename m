Message-ID: <3D109982.26B0EDE@opensource.se>
Date: Wed, 19 Jun 2002 16:47:30 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: =?iso-8859-1?Q?=C0=FC=C7=FD=BF=B5?= <hychon@corebell.co.kr>
Cc: linuxppc_mailing <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: can I  find the patch files for mpc860T
References: <001d01c2173a$557e2e70$cf6eb796@corebellhychon>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Search the list!

http://lists.linuxppc.org/

See this answer for more information:

http://lists.linuxppc.org/linuxppc-embedded/200103/msg00026.html

/ Magnus

ÀüÇý¿µ wrote:
>
> hello !
>
> I have some problems, when I compile with bash-2.05a  for Powerpc (mpc860).
> I download the sources from LFS stie , but it is not support for MPC860T
> when I build the sources, it was occur some errors with following error message
>
> can you help me what's problem and I can find the patch files for mpc860T
>
> ==== error MESAGE =====================
>
> [root@CBLinux bash-2.05a]# CC=powerpc-linux-gcc AR=powerpc-linux-ar
> RANLIB=powerpc-linux-ranlib ./configure --host=powerpc-linux
> --build=i686-pc-linux-gnu
>
> checking build system type... i686-pc-linux-gnu
> checking host system type... powerpc-unknown-linux-gnu
> Beginning configuration for bash-2.05a for powerpc-unknown-linux-gnu
> checking for powerpc-linux-gcc... powerpc-linux-gcc
> checking whether powerpc-linux-gcc needs -traditional... no
> checking for a BSD compatible install... /usr/bin/install -c
> checking for ar... powerpc-linux-ar
> checking for powerpc-linux-ranlib... powerpc-linux-ranlib
> checking for bison... bison -y
> checking whether make sets ${MAKE}... yes
> checking for powerpc-linux-gcc option to accept ANSI C... none needed
> checking for an ANSI C-conforming const... yes
> checking for inline... inline
> checking whether byte ordering is bigendian... yes
> checking for preprocessor stringizing operator... yes
> checking for long double... yes
> checking for function prototypes... yes
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking whether char is unsigned... yes
> checking for dirent.h that defines DIR... yes
> checking for opendir in -ldir... no
> checking whether time.h and sys/time.h may both be included... yes
> checking for inttypes.h... (cached) yes
> checking for unistd.h... (cached) yes
> checking for stdlib.h... (cached) yes
> checking for stdarg.h... yes
> checking for varargs.h... yes
> checking for limits.h... yes
> checking for string.h... (cached) yes
> checking for memory.h... (cached) yes
> checking for locale.h... yes
> checking for termcap.h... yes
> checking for termio.h... yes
> checking for termios.h... yes
> checking for dlfcn.h... yes
> checking for stddef.h... yes
> checking for stdint.h... (cached) yes
> checking for netdb.h... yes
> checking for grp.h... yes
> checking for strings.h... (cached) yes
> checking for sys/ptem.h... no
> checking for sys/pte.h... no
> checking for sys/stream.h... no
> checking for sys/select.h... yes
> checking for sys/file.h... yes
> checking for sys/resource.h... yes
> checking for sys/param.h... yes
> checking for sys/socket.h... yes
> checking for sys/time.h... yes
> checking for sys/times.h... yes
> checking for sys/wait.h... yes
> checking for netinet/in.h... yes
> checking for arpa/inet.h... yes
> checking for working alloca.h... yes
> checking for alloca... yes
> checking whether getpgrp takes no argument... yes
> checking whether setvbuf arguments are reversed... configure: error: cannot run test program while cross compiling
> =======================================
>
> This version is not support for powerpc architecture??
> if you have a some solutions, please help me !
> Do you know where I can get some patchs???
>
> thanks for reading and have a good day!
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
