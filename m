Message-ID: <01BF5059.4564AB40@hoang.pacific.net.sg>
From: Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>
To: "'Gould, Rick'" <RGould@placethecall.com>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
        "mmporter@home.com" <mmporter@home.com>
Subject: RE: glibc patch question and error help for building ppc cross compiler
Date: Mon, 27 Dec 1999 10:58:02 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

 I did follow that sequence and  I can  compile successfully. But I always have to manually set the path to /usr/local/bin:
	PATH=/usr/local/bin:$PATH
 after finishing binutils,gcc,kernel..This's not written in the guide.

 Hope this can help
 Hoang


-----Original Message-----
From:	Gould, Rick [SMTP:RGould@placethecall.com]
Sent:	Tuesday, June 27, 2000 6:16 AM
To:	linuxppc-embedded@lists.linuxppc.org; mmporter@home.com
Subject:	glibc patch question and error help for building ppc cross compiler


I'm trying to build a cross-development tool chain for building under Red
Hat Linux 6.2 on an x86 platform targeting a Brignt Star Engineering MPC-823
PowerPC-based board.  I've run into an error, and have a glibc patch
question.

Section 6 of "The Linux for PowerPC Embedded Systems HOWTO" at
http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO-6.html points
to "Cross Development for Linux/PPC" at
http://members.home.net/mmporter/linux/cross/ with instructions on building
the cross compiler tool chain.  I downloaded binutils-2.10.0.9,
gcc-core-2.95.2, glibc-2.1.3, glibc-crypt-2.1, glibc-linuxthreads-2.1.3, and
the glibc patch at
http://members.home.net/mmporter/linux/cross/glibc-2.1.3-ctype.patch.  I've
followed all the steps successfully up to the glibc make step.  After much
compiling, the compilation of sysdeps/generic/uname.c fails with
"config-name.h, No such file or directory":

make[2]: Entering directory `/usr/local/glibc-2.1.3/posix'
powerpc-linux-gcc ../sysdeps/generic/uname.c -c -O -Wall -Winline
-Wstrict-prototypes -Wwrite-strings -g      -I../include -I.
-I/usr/local/glibc-2.1.3/build/posix -I.. -I../libio
-I/usr/local/glibc-2.1.3/build -I../sysdeps/powerpc/elf
-I../crypt/sysdeps/unix -I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv
-I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc
-I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix
-I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic  -nostdinc -isystem
/usr/local/lib/gcc-lib/powerpc-linux/2.95.2/include -isystem
/usr/local/powerpc-linux/include -D_LIBC_REENTRANT -include
./include/libc-symbols.h     -o /usr/local/glibc-2.1.3/build/posix/uname.o
./sysdeps/generic/uname.c:25: config-name.h: No such file or directory
make[2]: *** [/usr/local/glibc-2.1.3/build/posix/uname.o] Error 1
make[2]: Leaving directory `/usr/local/glibc-2.1.3/posix'
make[1]: *** [posix/subdir_lib] Error 2
make[1]: Leaving directory `/usr/local/glibc-2.1.3'
make: *** [all] Error 2

---------------------------------------
Any help in resolving this would be greatly appreciated!

As to the glibc patch question, I thought I'd better get it clarified in
case it is the source of my problem.  The instructions I'm following above
apply one patch, but is this the same as the patches described in Section 12
of the HOWTO at
http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO-12.html?  This
points to the patch descriptions at
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html,
and also include different configure parameters than do the other
instructions I'm following.

---------------------------------------

Thanks for any help.  I am new to the GNU/Linux world, so I apologize ahead
of time if there is an obvious answer staring me in the face that I should
realize!

Rick Gould
Integrated Data Communications
rgould@PlaceTheCall.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
