Message-ID: <001901bfa9a9$2a7c0040$efc5dba8@sec.samsung.co.kr>
From: "kim sook young" <icekim@sec.samsung.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Error: Building glibc
Date: Wed, 19 Apr 2000 11:44:21 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all
While building glibc, I got an error like the following

---------------------------------------------------------------------------------
.......................................................
In file included from ../sysdeps/unix/sysv/linux/powerpc/profil-counter.h:2,
                 from ../sysdeps/posix/profil.c:54,
                 from ../sysdeps/unix/sysv/linux/profil.c:3:
../sysdeps/unix/sysv/linux/i386/profil-counter.h: In function `profil_counter':
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: structure has no member named `regs'
../sysdeps/posix/profil.c:39: warning: inlining failed in call to `profil_count'
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: warning: called from here
make[2]: *** [/home/icekim/Cross-Compiler/Glibc/glibc-2.1.3/build/gmon/profil.o] Error 1
make[2]: Leaving directory `/home/icekim/Cross-Compiler/Glibc/glibc-2.1.3/gmon'
make[1]: *** [gmon/subdir_lib] Error 2
make[1]: Leaving directory `/home/icekim/Cross-Compiler/Glibc/glibc-2.1.3'
make: *** [all] Error 2
---------------------------------------------------------------------------------
I think glibc(as you can see:2.1.3) and compiler(2.95.2) versions are the latest ones. I also perfomed the following configuration to build glibc. ( Actually  in order to install Binutils, Gcc and LibC, I followed the instructions only except for  building linux/ppc kernel )


CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib ../configure --host=powerpc-linux --with-headers=/usr/src/linux/include --enable-add-ons=crypt, linuxthreads --prefix=/usr/local/powerpc-linux

What's wrong in the environment? What should I do solve the problem? Should I have built the linux/ppc kernel which might be related with this error?

Please help me out..

e-mail: icekim@sec.samsung.co.kr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
