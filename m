Return-Path: <vinay453.techie@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id A9E7EDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 00:14:00 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so46017anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 05:13:59 -0800 (PST)
Message-ID: <e8e184520801240513x4420c32dhc4f4560b24197cfb@mail.gmail.com>
Date: Thu, 24 Jan 2008 18:43:59 +0530
From: "vinay kumar" <vinay453.techie@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: checking installed Linux kernel header files... TOO OLD!
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11088_7508652.1201180439239"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11088_7508652.1201180439239
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All gurus,
I need help.
While installing glibc , i encountered some errors. Kindly guide me of how
to deal with it.

#../glibc-2.3.2/configure --prefix=/opt/buckeye/powerpc-linux
--target=powerpc-linux --host=powerpc-linux  --enable-add-ons=linuxthreads
--with-headers=/root/Desktop/systemsim/include/
--with-binutils=/opt/buckeye/powerpc-linux/powerpc-linux/bin
--disable-sanity-checks

configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking build system type... i686-pc-linux-gnu
checking host system type... powerpc-unknown-linux-gnu
checking sysdep dirs... sysdeps/powerpc/powerpc32/elf sysdeps/powerpc/elf
linuxthreads/sysdeps/unix/sysv/linux/powerpc/powerpc32
linuxthreads/sysdeps/unix/sysv/linux/powerpc
linuxthreads/sysdeps/unix/sysv/linux linuxthreads/sysdeps/pthread
sysdeps/pthread linuxthreads/sysdeps/unix/sysv linuxthreads/sysdeps/unix
linuxthreads/sysdeps/powerpc/powerpc32 linuxthreads/sysdeps/powerpc
sysdeps/unix/sysv/linux/powerpc/powerpc32 sysdeps/unix/sysv/linux/powerpc
sysdeps/unix/sysv/linux sysdeps/gnu sysdeps/unix/common sysdeps/unix/mman
sysdeps/unix/inet sysdeps/unix/sysv sysdeps/unix/powerpc sysdeps/unix
sysdeps/posix sysdeps/powerpc/powerpc32/fpu sysdeps/powerpc/powerpc32
sysdeps/wordsize-32 sysdeps/powerpc/soft-fp sysdeps/powerpc/fpu
sysdeps/powerpc sysdeps/ieee754/flt-32 sysdeps/ieee754/dbl-64
sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for pwd... /bin/pwd
checking for powerpc-linux-gcc... powerpc-linux-gcc
checking version of powerpc-linux-gcc... 3.3.2, ok
checking for gnumake... no
checking for gmake... gmake
checking version of gmake... 3.80, ok
checking for gnumsgfmt... no
checking for gmsgfmt... no
checking for msgfmt... msgfmt
checking version of msgfmt... 0.14.1, ok
checking for makeinfo... makeinfo
checking version of makeinfo... 4.7, ok
checking for sed... sed
checking version of sed... 4.1.2, ok
checking for powerpc-linux-gcc... (cached) powerpc-linux-gcc
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether powerpc-linux-gcc accepts -g... yes
checking for powerpc-linux-gcc option to accept ANSI C... none needed
checking for gcc... gcc
checking how to run the C preprocessor... powerpc-linux-gcc -E
checking whether /opt/buckeye/powerpc-linux/powerpc-linux/bin/as is GNU
as... yes
checking whether /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld is GNU
ld... yes
checking for /opt/buckeye/powerpc-linux/powerpc-linux/bin/as...
/opt/buckeye/powerpc-linux/powerpc-linux/bin/as
checking version of /opt/buckeye/powerpc-linux/powerpc-linux/bin/as... 2.14,
ok
checking for /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld...
/opt/buckeye/powerpc-linux/powerpc-linux/bin/ld
checking version of /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld... 2.14,
ok
checking whether ranlib is necessary... no
checking LD_LIBRARY_PATH variable... ok
checking whether GCC supports -static-libgcc... -static-libgcc
checking for bash... /bin/sh
checking for gawk... gawk
checking for perl... /usr/bin/perl
checking for install-info... /sbin/install-info
checking for old Debian install-info... no
checking for bison... /usr/bin/bison
checking for signed size_t type... no
checking for libc-friendly stddef.h... yes
checking whether we need to use -P to assemble .S files... no
checking whether .text pseudo-op must be used... yes
checking for assembler global-symbol directive... .globl
checking for .set assembler directive... no
checking for assembler .type directive prefix... @
checking for .symver assembler directive... yes
checking for ld --version-script... yes
checking for .previous assembler directive... yes
checking for .protected and .hidden assembler directive... yes
checking whether __attribute__((visibility())) is supported... yes
checking for broken __attribute__((visibility()))... no
checking for broken __attribute__((alias()))... no
checking whether to put _rtld_local into .sdata section... yes
checking for .preinit_array/.init_array/.fini_array support... yes
checking for -z nodelete option... yes
checking for -z nodlopen option... yes
checking for -z initfirst option... yes
checking for -Bgroup option... yes
checking for -z combreloc... yes
checking whether cc puts quotes around section names... no
checking for assembler .weak directive... yes
checking for ld --no-whole-archive... yes
checking for gcc -fexceptions... yes
checking whether clobbering cr0 causes problems... no
checking for DWARF2 unwind info support... yes
checking for __builtin_expect... yes
checking for __builtin_memset... no
checking for local label subtraction... yes
checking for __thread... no
checking for libgd... no
checking for egrep... grep -E
checking for ANSI C header files... no
checking for sys/types.h... no
checking for sys/stat.h... no
checking for stdlib.h... no
checking for string.h... no
checking for memory.h... no
checking for strings.h... no
checking for inttypes.h... no
checking for stdint.h... no
checking for unistd.h... no
checking for long double... no
checking size of long double... 0
running configure fragment for ../glibc-2.3.2/sysdeps/pthread
running configure fragment for ../glibc-2.3.2/sysdeps/unix/sysv/linux
checking for egrep... (cached) grep -E
*checking installed Linux kernel header files... TOO OLD!
configure: error: GNU libc requires kernel header files from
Linux 2.0.10 or later to be installed before configuring.
The kernel header files are found usually in /usr/include/asm and
/usr/include/linux; make sure these directories use files from
Linux 2.0.10 or later.  This check uses <linux/version.h>, so
make sure that file was built correctly when installing the kernel header
files.  To use kernel headers not from /usr/include/linux, use the
configure option --with-headers.*

Thanks and regards.
Vinay

------=_Part_11088_7508652.1201180439239
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All gurus,<br>I need help.<br>While installing glibc , i encountered some errors. Kindly guide me of how to deal with it.<br><br>#../glibc-2.3.2/configure --prefix=/opt/buckeye/powerpc-linux --target=powerpc-linux --host=powerpc-linux&nbsp; --enable-add-ons=linuxthreads --with-headers=/root/Desktop/systemsim/include/ --with-binutils=/opt/buckeye/powerpc-linux/powerpc-linux/bin --disable-sanity-checks
<br><br>configure: WARNING: If you wanted to set the --build type, don&#39;t use --host.<br>&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>checking build system type... i686-pc-linux-gnu<br>checking host system type... powerpc-unknown-linux-gnu
<br>checking sysdep dirs... sysdeps/powerpc/powerpc32/elf sysdeps/powerpc/elf linuxthreads/sysdeps/unix/sysv/linux/powerpc/powerpc32 linuxthreads/sysdeps/unix/sysv/linux/powerpc linuxthreads/sysdeps/unix/sysv/linux linuxthreads/sysdeps/pthread sysdeps/pthread linuxthreads/sysdeps/unix/sysv linuxthreads/sysdeps/unix linuxthreads/sysdeps/powerpc/powerpc32 linuxthreads/sysdeps/powerpc sysdeps/unix/sysv/linux/powerpc/powerpc32 sysdeps/unix/sysv/linux/powerpc sysdeps/unix/sysv/linux sysdeps/gnu sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet sysdeps/unix/sysv sysdeps/unix/powerpc sysdeps/unix sysdeps/posix sysdeps/powerpc/powerpc32/fpu sysdeps/powerpc/powerpc32 sysdeps/wordsize-32 sysdeps/powerpc/soft-fp sysdeps/powerpc/fpu sysdeps/powerpc sysdeps/ieee754/flt-32 sysdeps/ieee754/dbl-64 sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic
<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether ln -s works... yes<br>checking for pwd... /bin/pwd<br>checking for powerpc-linux-gcc... powerpc-linux-gcc<br>checking version of powerpc-linux-gcc... 
3.3.2, ok<br>checking for gnumake... no<br>checking for gmake... gmake<br>checking version of gmake... 3.80, ok<br>checking for gnumsgfmt... no<br>checking for gmsgfmt... no<br>checking for msgfmt... msgfmt<br>checking version of msgfmt... 
0.14.1, ok<br>checking for makeinfo... makeinfo<br>checking version of makeinfo... 4.7, ok<br>checking for sed... sed<br>checking version of sed... 4.1.2, ok<br>checking for powerpc-linux-gcc... (cached) powerpc-linux-gcc
<br>checking for suffix of object files... o<br>checking whether we are using the GNU C compiler... yes<br>checking whether powerpc-linux-gcc accepts -g... yes<br>checking for powerpc-linux-gcc option to accept ANSI C... none needed
<br>checking for gcc... gcc<br>checking how to run the C preprocessor... powerpc-linux-gcc -E<br>checking whether /opt/buckeye/powerpc-linux/powerpc-linux/bin/as is GNU as... yes<br>checking whether /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld is GNU ld... yes
<br>checking for /opt/buckeye/powerpc-linux/powerpc-linux/bin/as... /opt/buckeye/powerpc-linux/powerpc-linux/bin/as<br>checking version of /opt/buckeye/powerpc-linux/powerpc-linux/bin/as... 2.14, ok<br>checking for /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld... /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld
<br>checking version of /opt/buckeye/powerpc-linux/powerpc-linux/bin/ld... 2.14, ok<br>checking whether ranlib is necessary... no<br>checking LD_LIBRARY_PATH variable... ok<br>checking whether GCC supports -static-libgcc... -static-libgcc
<br>checking for bash... /bin/sh<br>checking for gawk... gawk<br>checking for perl... /usr/bin/perl<br>checking for install-info... /sbin/install-info<br>checking for old Debian install-info... no<br>checking for bison... /usr/bin/bison
<br>checking for signed size_t type... no<br>checking for libc-friendly stddef.h... yes<br>checking whether we need to use -P to assemble .S files... no<br>checking whether .text pseudo-op must be used... yes<br>checking for assembler global-symbol directive... .globl
<br>checking for .set assembler directive... no<br>checking for assembler .type directive prefix... @<br>checking for .symver assembler directive... yes<br>checking for ld --version-script... yes<br>checking for .previous assembler directive... yes
<br>checking for .protected and .hidden assembler directive... yes<br>checking whether __attribute__((visibility())) is supported... yes<br>checking for broken __attribute__((visibility()))... no<br>checking for broken __attribute__((alias()))... no
<br>checking whether to put _rtld_local into .sdata section... yes<br>checking for .preinit_array/.init_array/.fini_array support... yes<br>checking for -z nodelete option... yes<br>checking for -z nodlopen option... yes<br>
checking for -z initfirst option... yes<br>checking for -Bgroup option... yes<br>checking for -z combreloc... yes<br>checking whether cc puts quotes around section names... no<br>checking for assembler .weak directive... yes
<br>checking for ld --no-whole-archive... yes<br>checking for gcc -fexceptions... yes<br>checking whether clobbering cr0 causes problems... no<br>checking for DWARF2 unwind info support... yes<br>checking for __builtin_expect... yes
<br>checking for __builtin_memset... no<br>checking for local label subtraction... yes<br>checking for __thread... no<br>checking for libgd... no<br>checking for egrep... grep -E<br>checking for ANSI C header files... no<br>
checking for sys/types.h... no<br>checking for sys/stat.h... no<br>checking for stdlib.h... no<br>checking for string.h... no<br>checking for memory.h... no<br>checking for strings.h... no<br>checking for inttypes.h... no
<br>checking for stdint.h... no<br>checking for unistd.h... no<br>checking for long double... no<br>checking size of long double... 0<br>running configure fragment for ../glibc-2.3.2/sysdeps/pthread<br>running configure fragment for ../glibc-
2.3.2/sysdeps/unix/sysv/linux<br>checking for egrep... (cached) grep -E<br><b>checking installed Linux kernel header files... TOO OLD!<br>configure: error: GNU libc requires kernel header files from<br>Linux 2.0.10 or later to be installed before configuring.
<br>The kernel header files are found usually in /usr/include/asm and<br>/usr/include/linux; make sure these directories use files from<br>Linux 2.0.10 or later.&nbsp; This check uses &lt;linux/version.h&gt;, so<br>make sure that file was built correctly when installing the kernel header
<br>files.&nbsp; To use kernel headers not from /usr/include/linux, use the<br>configure option --with-headers.</b><br><br>Thanks and regards.<br>Vinay<br>

------=_Part_11088_7508652.1201180439239--
