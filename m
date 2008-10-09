Return-Path: <ademirzanetti@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 5604DDDFA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 06:08:21 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so101353fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Oct 2008 12:08:18 -0700 (PDT)
Message-ID: <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>
Date: Thu, 9 Oct 2008 16:08:18 -0300
From: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Toolchain for ppc-440 without FPU
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_101421_3980348.1223579298846"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_101421_3980348.1223579298846
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I am trying to create a toolchain by hand and I am facing some problems when
I try to configure the glibc 2.7 for a powerpc. When I try to configure the
glibc to install the headers I get the following error:

configure --prefix=/usr --host=powerpc-440-linux-gnu
--with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs
--with-binutils=/home/azanetti/ml507/powerpc/bin/

checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
configure: running configure fragment for add-on nptl
checking sysdep dirs... sysdeps/i386/elf
nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386
sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux
nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu
sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet
sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv
sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix
sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686
sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu nptl/sysdeps/i386
sysdeps/i386 sysdeps/wordsize-32 sysdeps/ieee754/ldbl-96
sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sysdeps/ieee754
sysdeps/generic/elf sysdeps/generic
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for gcc... gcc
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking how to run the C preprocessor... gcc -E
checking for g++... g++

.
.
.
checking for long double... yes
checking size of long double... 12
running configure fragment for sysdeps/powerpc/powerpc32/elf
checking for powerpc32 TLS support... no
running configure fragment for sysdeps/unix/sysv/linux/powerpc
checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2
-mlong-double-128 uses IBM extended format... no
checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports
-mabi=ibmlongdouble... no
configure: error: this configuration requires -mlong-double-128 IBM extended
format support


I already have the binutils 2.18 compiled on my PATH. I know that it is
easier to use a script like crosstool to compile it but I do want to
understand what is happening behind the scenes.

Regards.

Ademir

------=_Part_101421_3980348.1223579298846
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hello all,<br><br>I am trying to create a toolchain by hand and I am facing some problems when I try to configure the glibc 2.7 for a powerpc. When I try to configure the glibc to install the headers I get the following error:<br>
<br><font style="font-family: courier new,monospace;" size="1">configure --prefix=/usr --host=powerpc-440-linux-gnu --with-headers=${SYSROOT}/usr/include --disable-shared --without-cvs --with-binutils=/home/azanetti/ml507/powerpc/bin/<br>
<br>checking build system type... i686-pc-linux-gnu<br>checking host system type... i686-pc-linux-gnu<br>configure: running configure fragment for add-on nptl<br>checking sysdep dirs... sysdeps/i386/elf nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386 sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/inet sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686 sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32 sysdeps/ieee754/ldbl-96 sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic<br>
checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether ln -s works... yes<br>checking for gcc... gcc<br>checking for suffix of object files... o<br>checking whether we are using the GNU C compiler... yes<br>
checking whether gcc accepts -g... yes<br>checking for gcc option to accept ISO C89... none needed<br>checking how to run the C preprocessor... gcc -E<br>checking for g++... g++<br><br>.<br>.<br>.<br>checking for long double... yes<br>
checking size of long double... 12<br>running configure fragment for sysdeps/powerpc/powerpc32/elf<br>checking for powerpc32 TLS support... no<br>running configure fragment for sysdeps/unix/sysv/linux/powerpc<br>checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 -mlong-double-128 uses IBM extended format... no<br>
checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports -mabi=ibmlongdouble... no<br>configure: error: this configuration requires -mlong-double-128 IBM extended format support<br><br></font><br>I already have the binutils 2.18 compiled on my PATH. I know that it is easier to use a script like crosstool to compile it but I do want to understand what is happening behind the scenes.<br>
<br>Regards.<br><br>Ademir<br></div>

------=_Part_101421_3980348.1223579298846--
