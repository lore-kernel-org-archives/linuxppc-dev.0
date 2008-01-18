Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 06E72DDECB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 09:34:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85A22.38341666"
Subject: ping 127.0.0.1 takes too much
Date: Fri, 18 Jan 2008 23:33:59 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1A@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

------_=_NextPart_001_01C85A22.38341666
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have two different boards: one with MPC875 running at 66 MHz cpu/66 =
MHz bus, one with MPC880 running at 132 MHz cpu /66MHz bus, I load the =
same kernel and root file system on both the boards that have only =
different u-boot(s).

If I do a ping 127.0.0.1 on the MPC875 I get a round trip of 0.300 ms, =
while on the other one I get 0.900 ms, I expected the opposite.

Could be an issue with memory configuration? In the formula to calculate =
the PTx on the MPC885RM manual I used 66 MHz as "system clock" for the =
first board and 132 MHz for the second board. Probably this is a mistake =
because "system clock" should be the bus clock but how this can so =
adversely affect the ping round trip?

Thank you,
Antonio.

------_=_NextPart_001_01C85A22.38341666
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>ping 127.0.0.1 takes too much</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I have two different boards: one with MPC875 running =
at 66 MHz cpu/66 MHz bus, one with MPC880 running at 132 MHz cpu /66MHz =
bus, I load the same kernel and root file system on both the boards that =
have only different u-boot(s).<BR>
<BR>
If I do a ping 127.0.0.1 on the MPC875 I get a round trip of 0.300 ms, =
while on the other one I get 0.900 ms, I expected the opposite.<BR>
<BR>
Could be an issue with memory configuration? In the formula to calculate =
the PTx on the MPC885RM manual I used 66 MHz as &quot;system clock&quot; =
for the first board and 132 MHz for the second board. Probably this is a =
mistake because &quot;system clock&quot; should be the bus clock but how =
this can so adversely affect the ping round trip?<BR>
<BR>
Thank you,<BR>
Antonio.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C85A22.38341666--
