Message-ID: <38CEEF3B.2665CD22@m2tech.co.nz>
Date: Wed, 15 Mar 2000 15:02:35 +1300
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: compiling glibc for 4xx core powerpc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all..

i am attempting to compile glibc for my platform (4xx core powerpc) and
as this core doesnt have an fpu, am compiling with -msoft-float.. but it
dont work.. during compile i receive this error:

../sysdeps/powerpc/s_isnan.c:27: Invalid `asm' statement:
../sysdeps/powerpc/s_isnan.c:27: fixed or forbidden register 32 (0) was
spilled for class FLOAT_REGS.

(this occurs on an attempted assemble of a fpu instruction)

my system specs are:
 - compiling with gcc 2.95.2 native on powermac g4
 - glibc 2.1.3
 - kernel(powermac)=2.2.15pre14
 - kernel(4xx)=2.3.42 + patches
 - glibc configure options: configure --target=powerpc-linux
--host=powerpc-linux
     --enable-add-ons=crypt, linuxthreads --prefix=/usr/local/ppc403
--without-fp
 - CFLAGS extras: -msoft-float -DNDEBUG=1 -O2

does anyone have a clue as to what is going on?? will i have to add some
sort of software emulated floating point support in the kernel (use 8xx
emu)?? or am i just missing a compiler option??

is it worth using this late revision of glibc, or am i better off to use
an earlier/simpler revision??

cheers for any insights!

ben


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
