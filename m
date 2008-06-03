Return-Path: <jose.franca@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
	[217.115.75.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91C12DE986
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 04:02:10 +1000 (EST)
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
	m53I2181017485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 20:02:01 +0200
Received: from demuexc023.nsn-intra.net (webmail.nsn-intra.net [10.150.128.36])
	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP
	id m53I1upU011104
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 20:02:01 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C5A3.EAD71A09"
Subject: Invalidate_dcache_range causes crash in non-cacheable area
Date: Tue, 3 Jun 2008 19:01:21 +0100
Message-ID: <56DEE2D3217CD946B290399093C8FA7C2DF3FC@PTLIEXC001.nsn-intra.net>
From: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8C5A3.EAD71A09
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Community!

	I'm using 8MB of memory for DMA and that space is configured has
non-cacheable. At a certain point in the code, data is copied to be
processed from that area. In the function that copies, there was an
invalidate_dcache_range for the all DMA area. This function crashed my
load in some particular scenario of heavy traffic. Why? Shouldn't
invalidate_dcache_range be neutral when the range is configured as
non-cacheable? I think that the memory is properly alined... Has anyone
else had this problem?


Best regards
Filipe.


------_=_NextPart_001_01C8C5A3.EAD71A09
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.14">
<TITLE>Invalidate_dcache_range causes crash in non-cacheable =
area</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello Community!</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">I'm using 8MB of memory for DMA and that space is =
configured has non-cacheable. At a certain point in the code, data is =
copied to be processed from that area. In the function that copies, =
there was an&nbsp; invalidate_dcache_range for the all DMA area. This =
function crashed my load in some particular scenario of heavy traffic. =
Why? Shouldn't invalidate_dcache_range be neutral when the range is =
configured as non-cacheable? I think that the memory is properly =
alined&#8230; Has anyone else had this problem?</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best regards</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Filipe.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8C5A3.EAD71A09--
