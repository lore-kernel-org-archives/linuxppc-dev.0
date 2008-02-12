Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 4A568DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 06:47:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86DAF.EB3ABA4D"
Subject: ROOTFS on NAND FLASH is too slow?
Date: Tue, 12 Feb 2008 20:46:11 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264A50@aquib01a>
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

------_=_NextPart_001_01C86DAF.EB3ABA4D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have board with a nand flash. It is connected to the micro (ATMEL =
L9260) via a serial bus and not a parallel one as with NOR flash.=20
Is feasible to have the rootfs on the nand flash? Is not too slow? What =
is usually done in this case? Is not better to copy the whole filesystem =
in RAM?

Thank you,
Antonio.


------_=_NextPart_001_01C86DAF.EB3ABA4D
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
<TITLE>ROOTFS on NAND FLASH is too slow?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I have board with a nand flash. It is connected to the micro (ATMEL =
L9260) via a serial bus and not a parallel one as with NOR flash.<BR>
Is feasible to have the rootfs on the nand flash? Is not too slow? What =
is usually done in this case? Is not better to copy the whole filesystem =
in RAM?<BR>
<BR>
Thank you,<BR>
Antonio.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C86DAF.EB3ABA4D--
