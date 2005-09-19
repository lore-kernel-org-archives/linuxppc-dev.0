Return-Path: <peter.fercher@scs.ch>
Received: from mail.scs.ch (mail.scs.ch [212.254.229.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD4BF6832B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 23:37:28 +1000 (EST)
From: "Peter Fercher" <peter.fercher@scs.ch>
To: <benh@kernel.crashing.org>
Date: Mon, 19 Sep 2005 15:37:07 +0200
Message-ID: <004101c5bd1f$3d1b91e0$dbe5fed4@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0042_01C5BD30.00A461E0"
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: emac driver broken in 2.6.12.2 ?
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

------=_NextPart_000_0042_01C5BD30.00A461E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

hi,
 
i have problems with the IBM EMAC with 2.6.12.2 (the driver worked with
2.4.25)
running on ppc405EP octobus board. Cross compiled on x86 using the eldk-3.1
toolchain
 
any hints ?
 
emac: IBM EMAC Ethernet driver, version 2.0

Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>

eth0: IBM emac, MAC 00:00:00:00:00:00

eth0: Found Generic MII PHY (0x00)

eth1: IBM emac, MAC 00:00:00:00:00:00

eth1: Found Generic MII PHY (0x01)

 
cheers, peter

---------------------------------------------------------
Supercomputing Systems AG    phone:  +41 (0)43 456 16 31
Peter Fercher                fax:    +41 (0)43 456 16 10
Technoparkstrasse 1          email:  peter.fercher@scs.ch
CH-8005 Zuerich              url:    http://www.scs.ch <http://www.scs.ch/>

---------------------------------------------------------
  

 

------=_NextPart_000_0042_01C5BD30.00A461E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1515" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D173253413-19092005>hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D173253413-19092005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D173253413-19092005>i have =
problems with=20
the IBM EMAC with 2.6.12.2 (the driver worked=20
with&nbsp;2.4.25)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D173253413-19092005>running on ppc405EP=20
octobus board. Cross compiled on x86 using the eldk-3.1=20
toolchain</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D173253413-19092005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D173253413-19092005>any =
hints=20
?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>emac: IBM EMAC Ethernet driver, version =

2.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
<BR>Maintained by Benjamin Herrenschmidt &lt;<A=20
href=3D"mailto:benh@kernel.crashing.org">benh@kernel.crashing.org</A>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>eth0: IBM emac, MAC=20
00:00:00:00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>eth0: Found Generic MII PHY=20
(0x00)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>eth1: IBM emac, MAC=20
00:00:00:00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>eth1: Found Generic MII PHY=20
(0x01)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D173253413-19092005><FONT face=3DArial =
size=3D2>cheers,=20
peter</FONT></SPAN></DIV>
<P><FONT=20
size=3D2>---------------------------------------------------------<BR>Sup=
ercomputing=20
Systems AG&nbsp;&nbsp;&nbsp; phone:&nbsp; +41 (0)43 456 16 31<BR>Peter=20
Fercher&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
fax:&nbsp;&nbsp;&nbsp; +41 (0)43 456 16 10<BR>Technoparkstrasse=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; email:&nbsp;=20
peter.fercher@scs.ch<BR>CH-8005=20
Zuerich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
url:&nbsp;&nbsp;&nbsp; <A href=3D"http://www.scs.ch/"=20
target=3D_blank>http://www.scs.ch</A>&nbsp;<BR>--------------------------=
-------------------------------<BR>&nbsp;</FONT>=20
</P>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0042_01C5BD30.00A461E0--
