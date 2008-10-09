Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 220AADE489
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 08:05:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C92A52.CD6CA400"
Subject: RE: Toolchain for ppc-440 without FPU
Date: Thu, 9 Oct 2008 16:05:47 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F80B@tanisys-ex2.Tanisys.Local>
In-Reply-To: <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>
References: <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C92A52.CD6CA400
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I was compiling for the 440FP under cygwin, I believe that I had to use
--enable-long-long when I configured gcc in order to build glibc.

________________________________

From: linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org] On
Behalf Of Ademir Zanetti Junior
Sent: Thursday, October 09, 2008 2:08 PM
To: linuxppc-embedded@ozlabs.org
Subject: Toolchain for ppc-440 without FPU


Hello all,

I am trying to create a toolchain by hand and I am facing some problems
when I try to configure the glibc 2.7 for a powerpc. When I try to
configure the glibc to install the headers I get the following error:

configure --prefix=3D/usr --host=3Dpowerpc-440-linux-gnu
--with-headers=3D${SYSROOT}/usr/include --disable-shared --without-cvs
--with-binutils=3D/home/azanetti/ml507/powerpc/bin/

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
sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu
nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32
sysdeps/ieee754/ldbl-96 sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32
sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic
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
-mabi=3Dibmlongdouble... no
configure: error: this configuration requires -mlong-double-128 IBM
extended format support


I already have the binutils 2.18 compiled on my PATH. I know that it is
easier to use a script like crosstool to compile it but I do want to
understand what is happening behind the scenes.

Regards.

Ademir


------_=_NextPart_001_01C92A52.CD6CA400
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16705" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D587420421-09102008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I was compiling for the 440FP under cygwin, I =
believe that=20
I had to use --enable-long-long when I configured gcc in order to build=20
glibc.</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B>=20
linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org] <B>On =
Behalf Of=20
</B>Ademir Zanetti Junior<BR><B>Sent:</B> Thursday, October 09, 2008 =
2:08=20
PM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
Toolchain for=20
ppc-440 without FPU<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV dir=3Dltr>Hello all,<BR><BR>I am trying to create a toolchain by =
hand and I=20
am facing some problems when I try to configure the glibc 2.7 for a =
powerpc.=20
When I try to configure the glibc to install the headers I get the =
following=20
error:<BR><BR><FONT style=3D"FONT-FAMILY: courier new,monospace" =
size=3D1>configure=20
--prefix=3D/usr --host=3Dpowerpc-440-linux-gnu =
--with-headers=3D${SYSROOT}/usr/include=20
--disable-shared --without-cvs=20
--with-binutils=3D/home/azanetti/ml507/powerpc/bin/<BR><BR>checking =
build system=20
type... i686-pc-linux-gnu<BR>checking host system type...=20
i686-pc-linux-gnu<BR>configure: running configure fragment for add-on=20
nptl<BR>checking sysdep dirs... sysdeps/i386/elf=20
nptl/sysdeps/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386 =

sysdeps/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux =
nptl/sysdeps/pthread=20
sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu sysdeps/unix/common=20
sysdeps/unix/mman sysdeps/unix/inet sysdeps/unix/sysv/i386=20
nptl/sysdeps/unix/sysv sysdeps/unix/sysv sysdeps/unix/i386 =
nptl/sysdeps/unix=20
sysdeps/unix sysdeps/posix sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686=20
sysdeps/i386/i686 sysdeps/i386/i486 nptl/sysdeps/i386/i486 =
sysdeps/i386/fpu=20
nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32 =
sysdeps/ieee754/ldbl-96=20
sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sysdeps/ieee754=20
sysdeps/generic/elf sysdeps/generic<BR>checking for a BSD-compatible =
install...=20
/usr/bin/install -c<BR>checking whether ln -s works... yes<BR>checking =
for=20
gcc... gcc<BR>checking for suffix of object files... o<BR>checking =
whether we=20
are using the GNU C compiler... yes<BR>checking whether gcc accepts =
-g...=20
yes<BR>checking for gcc option to accept ISO C89... none =
needed<BR>checking how=20
to run the C preprocessor... gcc -E<BR>checking for g++...=20
g++<BR><BR>.<BR>.<BR>.<BR>checking for long double... yes<BR>checking =
size of=20
long double... 12<BR>running configure fragment for=20
sysdeps/powerpc/powerpc32/elf<BR>checking for powerpc32 TLS support...=20
no<BR>running configure fragment for =
sysdeps/unix/sysv/linux/powerpc<BR>checking=20
whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 -mlong-double-128 =
uses=20
IBM extended format... no<BR>checking whether gcc=20
-B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports =
-mabi=3Dibmlongdouble...=20
no<BR>configure: error: this configuration requires -mlong-double-128 =
IBM=20
extended format support<BR><BR></FONT><BR>I already have the binutils =
2.18=20
compiled on my PATH. I know that it is easier to use a script like =
crosstool to=20
compile it but I do want to understand what is happening behind the=20
scenes.<BR><BR>Regards.<BR><BR>Ademir<BR></DIV></BODY></HTML>

------_=_NextPart_001_01C92A52.CD6CA400--
