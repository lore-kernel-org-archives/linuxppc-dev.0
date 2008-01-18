Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id D4DD4DDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 10:12:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85A27.9B7FE8CE"
Subject: RE: ping 127.0.0.1 takes too much
Date: Sat, 19 Jan 2008 00:10:53 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1B@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1A@aquib01a>
	<47912CDA.9020603@freescale.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C85A27.9B7FE8CE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>Are you sure the timebase clock is what the kernel thinks it is?  Does=20
>the time-of-day clock progress at the correct rate?

The kernel receives the CPU clock from the bdinfo structure and thus I =
think the kernel knows how fast the CPU is.=20

Bye,
Antonio.

------_=_NextPart_001_01C85A27.9B7FE8CE
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
<TITLE>RE: ping 127.0.0.1 takes too much</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>&gt;Are you sure the timebase clock is what the kernel =
thinks it is?&nbsp; Does<BR>
&gt;the time-of-day clock progress at the correct rate?<BR>
<BR>
The kernel receives the CPU clock from the bdinfo structure and thus I =
think the kernel knows how fast the CPU is.<BR>
<BR>
Bye,<BR>
Antonio.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C85A27.9B7FE8CE--
