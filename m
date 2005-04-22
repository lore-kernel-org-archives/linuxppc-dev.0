Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 8708767A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 06:21:48 +1000 (EST)
Received: from filter09.roc.ny.frontiernet.net
	(filter09.roc.ny.frontiernet.net [66.133.183.76])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id 256D03705DB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 19:50:18 +0000 (UTC)
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165])
	by filter09.roc.ny.frontiernet.net (filter09.roc.ny.frontiernet.net
	[66.133.183.76]) (amavisd-new, port 10024)
	with LMTP id 18066-11-80 for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 19:50:18 +0000 (UTC)
Received: from chuck2 (70-97-124-8.br1.rmn.wv.frontiernet.net [70.97.124.8])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id CA0A63703BF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 19:50:16 +0000 (UTC)
Message-ID: <002101c54774$83c85590$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 22 Apr 2005 15:50:18 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001E_01C54752.FBBC7710"
Subject: pthread debugging problem
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

------=_NextPart_000_001E_01C54752.FBBC7710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am debugging a simple program with several threads, using pthreads.=20
printf's tell me that the threading is working, but I am unable to debug
the program with gdb (gdbserver on the target).  I get spurious
'Program received signal SIG32, Real-time even 32' messages.
I'm using a stock ELDK tree via NFS boot.  I couldn't tell you the ELDK
version but I've listed some of the components below.

I've found postings in the general linux community, but they don't seem
to apply in this case.  I've compiled a late gdb (6.2), tried later =
versions
of all the libraries that seem relevant, to no avail.  Any ideas?  Or,
equally valuable, is anybody debugging pthreads successfully on ppc,
what is your setup?

Thanks,
Mark Chambers

versions:
libc-2.2.1
libpthread-0.9.so
kernel - 2.4.19
------=_NextPart_000_001E_01C54752.FBBC7710
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I am debugging a simple program with =
several=20
threads, using pthreads.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>printf's tell me that the threading is =
working, but=20
I am unable to debug</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>the program with gdb (gdbserver on the=20
target).&nbsp; I get spurious</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>'Program received signal SIG32, =
Real-time even 32'=20
messages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm using a stock ELDK tree via NFS =
boot.&nbsp; I=20
couldn't tell you the ELDK</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>version but I've listed some of the =
components=20
below.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I've found postings in the general =
linux community,=20
but they don't seem</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>to apply in this case.&nbsp; I've =
compiled a late=20
gdb (6.2), tried later versions</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>of all the libraries that seem =
relevant,&nbsp;to no=20
avail.&nbsp; Any ideas?&nbsp; Or,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>equally valuable, is anybody debugging =
pthreads=20
successfully on ppc,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>what is your setup?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Mark Chambers</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>versions:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>libc-2.2.1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>libpthread-0.9.so</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel - =
2.4.19</FONT></DIV></BODY></HTML>

------=_NextPart_000_001E_01C54752.FBBC7710--
