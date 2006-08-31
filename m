Return-Path: <Phil.Mathews@innocon.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CD10.BEB04127"
Subject: Unable to build ELDK 4.0
Date: Thu, 31 Aug 2006 11:18:42 -0400
Message-ID: <3E8081396F6B524BA2854E7FA3F16438042EB1DB@mail.innocon.com>
References: <5df98b760608310618p746e1ee7q62b9472fa855660f@mail.gmail.com>
From: "Mathews, Phil" <Phil.Mathews@innocon.com>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6CD10.BEB04127
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am attempting to build the ELDK kernel using the directions in =
/home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/README.  The makefile is =
trying to execute powerPC code (fixdep) on my Pentium box.  Where can I =
get a X86 version of this program?

##### Make attempt:
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> make =
O=3D/home/name/build/kernel menuconfig
  HOSTCC  scripts/basic/fixdep
/bin/sh: scripts/basic/fixdep: cannot execute binary file
make[2]: *** [scripts/basic/fixdep] Error 126
make[1]: *** [scripts_basic] Error 2
make: *** [menuconfig] Error 2

##### Objdump of scripts/basic/fixdep
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> objdump -a =
scripts/basic/fixdep

scripts/basic/fixdep:     file format elf32-powerpc
scripts/basic/fixdep

mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15> echo $PATH
/home/mathews/ELDK/usr/bin:/home/mathews/ELDK/usr/ppc-linux/bin:/home/mat=
hews/bin:/usr/local/bin:/usr/bin:/usr/X11R6/bin:/bin:/usr/games:/opt/gnom=
e/bin:/opt/kde3/bin


--  Phil Mathews =20
    phil.mathews _at_ innocon.com   =20

------_=_NextPart_001_01C6CD10.BEB04127
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>Unable to build ELDK 4.0</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I am attempting to build the ELDK kernel using the =
directions in =
/home/mathews/ELDK/ppc_6xx/usr/src/linux-2.6.15/README.&nbsp; The =
makefile is trying to execute powerPC code (fixdep) on my Pentium =
box.&nbsp; Where can I get a X86 version of this program?<BR>
<BR>
##### Make attempt:<BR>
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15&gt; make =
O=3D/home/name/build/kernel menuconfig<BR>
&nbsp; HOSTCC&nbsp; scripts/basic/fixdep<BR>
/bin/sh: scripts/basic/fixdep: cannot execute binary file<BR>
make[2]: *** [scripts/basic/fixdep] Error 126<BR>
make[1]: *** [scripts_basic] Error 2<BR>
make: *** [menuconfig] Error 2<BR>
<BR>
##### Objdump of scripts/basic/fixdep<BR>
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15&gt; objdump -a =
scripts/basic/fixdep<BR>
<BR>
scripts/basic/fixdep:&nbsp;&nbsp;&nbsp;&nbsp; file format =
elf32-powerpc<BR>
scripts/basic/fixdep<BR>
<BR>
mathews@mathews:~/ELDK/ppc_6xx/usr/src/linux-2.6.15&gt; echo $PATH<BR>
/home/mathews/ELDK/usr/bin:/home/mathews/ELDK/usr/ppc-linux/bin:/home/mat=
hews/bin:/usr/local/bin:/usr/bin:/usr/X11R6/bin:/bin:/usr/games:/opt/gnom=
e/bin:/opt/kde3/bin<BR>
<BR>
<BR>
--&nbsp; Phil Mathews&nbsp;<BR>
&nbsp;&nbsp;&nbsp; phil.mathews _at_ innocon.com&nbsp;&nbsp;&nbsp;<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6CD10.BEB04127--
