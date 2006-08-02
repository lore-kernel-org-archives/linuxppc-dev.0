Return-Path: <jose.franca.ext@siemens.com>
Received: from relay2.siemens.pt (relay-pt1.siemens.pt [194.145.62.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2BBA67B9E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 01:39:16 +1000 (EST)
Received: from fw-mta1.siemens.pt (fw-mta1.siemens.pt [141.29.156.201])
	by relay2.siemens.pt (8.12.8/8.12.9) with ESMTP id k72FPTEH010874
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 16:25:29 +0100
Received: from PTLISI052MSX.PT001.SIEMENS.NET (ptlisi052n01.pt001.siemens.net
	[141.29.156.67])
	by fw-mta1.siemens.pt (Hvm) with ESMTP id k72FXqB03258
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 16:33:52 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B649.0E769DDB"
Subject: Sloooooowwww CFI Flash programming
Date: Wed, 2 Aug 2006 16:33:51 +0100
Message-ID: <4051B1A83682514BA8529BCADDA45F086EE61D@PTLISI050MSX.PT001.SIEMENS.NET>
From: "Franca, Jose Filipe \(ext\)" <jose.franca.ext@siemens.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6B649.0E769DDB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all!

	I'm using a linux-2.4.31 based kernel in our board and we are using a =
AM29LV040B flash device. Our problem is that flash programming is a =
rather slow process. The responsible is the file cfi_cmdset_0002.c. Is =
there any patch that fixes this problem and enables fast programming =
mode?



Thanks for reading (and many more if you reply),
Filipe Fran=E7a.

------_=_NextPart_001_01C6B649.0E769DDB
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
<TITLE>Sloooooowwww CFI Flash programming</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"pt"><FONT SIZE=3D2 FACE=3D"Arial">Hello =
all!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
SIZE=3D2 FACE=3D"Arial">I'm using a linux-2.4.31 based kernel in our =
board and we are using a AM29LV040B flash device. Our problem is that =
flash programming is a rather slow process. The responsible is the file =
cfi_cmdset_0002.c. Is there any patch that fixes this problem and =
enables fast programming mode?</FONT></SPAN></P>
<BR>
<BR>

<P><SPAN LANG=3D"pt"><FONT SIZE=3D2 FACE=3D"Arial">Thanks for reading =
(and many more if you reply),</FONT></SPAN>

<BR><SPAN LANG=3D"pt"><FONT SIZE=3D2 FACE=3D"Arial">Filipe =
Fran=E7a.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6B649.0E769DDB--
