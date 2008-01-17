Return-Path: <peter.iring@siemens.com>
Received: from mxs2.siemens.at (mxs2.siemens.at [194.138.12.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95693DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 22:34:48 +1100 (EST)
Received: from vies1kbx.sie.siemens.at ([158.226.129.82])
	by mxs2.siemens.at  with ESMTP id m0HAbOx2021004
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Jan 2008 11:37:24 +0100
Received: from nets139a.ww300.siemens.net ([158.226.129.98])
	by vies1kbx.sie.siemens.at (8.12.11.20060308/8.12.1) with ESMTP id
	m0HAbA7W009429
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Jan 2008 11:37:18 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C858F4.E980CAA0"
Subject: TQM860L cross compilation problem
Date: Thu, 17 Jan 2008 11:37:09 +0100
Message-ID: <83F3FC3E61CF7C4CAD05A740C542833407365D42@btss020a.ww300.siemens.net>
From: "Iring, Peter" <peter.iring@siemens.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C858F4.E980CAA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello to all,
=20
I would like to crosscompile linux kernel 2.6.11.7 for TQM860L.
I have found on http://www.denx.de/wiki/Know/Linux24vs26 page that some
tests were done on this board.
=20
I have used kernel 2.6.11.7 from kernel.org and applied tosatti.patch on
it and config-2.6.11.7-TQM860L.
I am using ELDK 4.1 for cross compilation.
=20
But if I want to cross compile it, procedure stops with following
result:
=20
testnet@SK16085C:~/eldk_uclibc/ppc_8xx/usr/src/linux$ make ARCH=3Dppc
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/ppc/kernel/asm-offsets.s
  CHK     include/asm-ppc/offsets.h
  CC      init/main.o
In file included from include/asm/setup.h:8,
                 from include/asm/machdep.h:8,
                 from include/asm/irq.h:6,
                 from include/asm/hardirq.h:8,
                 from include/linux/hardirq.h:6,
                 from include/asm-generic/local.h:6,
                 from include/asm/local.h:4,
                 from include/linux/module.h:21,
                 from init/main.c:16:
include/asm-m68k/setup.h:365: error: array type has incomplete element
type
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Does anybody know what is going on?
=20
Thanks in advance
Peter

------_=_NextPart_001_01C858F4.E980CAA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>Hello =
to=20
all,</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>I =
would like to=20
crosscompile linux kernel 2.6.11.7 for TQM860L.</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>I have =
found on <A=20
href=3D"http://www.denx.de/wiki/Know/Linux24vs26">http://www.denx.de/wiki=
/Know/Linux24vs26</A>=20
page that some tests were done on this board.</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>I have =
used kernel=20
2.6.11.7 from kernel.org and applied tosatti.patch on it and=20
config-2.6.11.7-TQM860L.</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>I am =
using ELDK 4.1=20
for cross compilation.</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>But if =
I want to=20
cross compile it, procedure stops with following =
result:</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2><A=20
href=3D"mailto:testnet@SK16085C:~/eldk_uclibc/ppc_8xx/usr/src/linux$">tes=
tnet@SK16085C:~/eldk_uclibc/ppc_8xx/usr/src/linux$</A>=20
make ARCH=3Dppc<BR>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;=20
include/linux/version.h<BR>&nbsp; SPLIT&nbsp;&nbsp; =
include/linux/autoconf.h=20
-&gt; include/config/*<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
arch/ppc/kernel/asm-offsets.s<BR>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;=20
include/asm-ppc/offsets.h<BR>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
init/main.o<BR>In file included from=20
include/asm/setup.h:8,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/asm/machdep.h:8,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/asm/irq.h:6,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/asm/hardirq.h:8,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/linux/hardirq.h:6,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/asm-generic/local.h:6,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/asm/local.h:4,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
include/linux/module.h:21,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
from init/main.c:16:<BR>include/asm-m68k/setup.h:365: error: array type =
has=20
incomplete element type<BR>make[1]: *** [init/main.o] Error 1<BR>make: =
***=20
[init] Error 2<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>Does =
anybody know=20
what is going on?</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial size=3D2>Thanks =
in=20
advance</FONT></SPAN></DIV>
<DIV><SPAN class=3D883353010-17012008><FONT face=3DArial=20
size=3D2>Peter</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C858F4.E980CAA0--
