Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id A7184DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Nov 2007 10:03:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C823ED.E4F4E057"
Subject: mpc8xx_wdt.c : piscr is 16bit in linux2.4 but 32bit in linux2.6 ?!?!?!
Date: Sun, 11 Nov 2007 00:03:23 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E2649ED@aquib01a>
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

------_=_NextPart_001_01C823ED.E4F4E057
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

in mpc8xx_wdt.c in linux2.4 (denx distribution) piscr is 16bit long but =
in the same file in linux 2.6.19-2 (denx distribution) is read and =
written with in_be32 and out_be32. It's strange.

Bye.

------_=_NextPart_001_01C823ED.E4F4E057
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
<TITLE>mpc8xx_wdt.c : piscr is 16bit in linux2.4 but 32bit in linux2.6 =
?!?!?!</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi all,<BR>
<BR>
in mpc8xx_wdt.c in linux2.4 (denx distribution) piscr is 16bit long but =
in the same file in linux 2.6.19-2 (denx distribution) is read and =
written with in_be32 and out_be32. It's strange.<BR>
<BR>
Bye.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C823ED.E4F4E057--
