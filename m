Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B7E9CB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 17:37:00 +1000 (EST)
Received: from ns0.datapatterns.co.in (mx0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0914DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 17:36:59 +1000 (EST)
Received: from itd210 (itd210.datapatterns [10.5.4.110]) (authenticated bits=0)
	by ns0.datapatterns.co.in (8.14.2/8.14.2) with ESMTP id n7K7Yekt009261
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 13:04:41 +0530
Message-ID: <FAB1DE2EE83A4ADE85C4BF9408D22053@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <linuxppc-dev@ozlabs.org>
References: <e1ca2e7b0908192115o2cfa427fof21512757854901a@mail.gmail.com>
In-Reply-To: <e1ca2e7b0908192115o2cfa427fof21512757854901a@mail.gmail.com>
Subject: Re: Regarding TSI108 ethernet DMA issue
Date: Thu, 20 Aug 2009 13:01:30 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B7_01CA2196.55E9B0F0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00B7_01CA2196.55E9B0F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
        I found that the header file(dma-mapping.h) has changed. I saw =
this change has happened on Linux -2.6.28 kernel onwards. earlier kernel =
is having COMFIT_PPC64 macro. Based on this macro the things were =
happened. Is there any fixes available right now or any reasons behind =
this changes.=20
Regards,
T.
  ----- Original Message -----=20
  From: Thirumalai Pachamuthu=20
  To: linuxppc-dev@ozlabs.org=20
  Sent: Thursday, August 20, 2009 9:45 AM
  Subject: Regarding TSI108 ethernet DMA issue


  Hi all,
        I am trying to port linux 2.6.30 for my TSI108 based custom =
board where i am getting the following kernel panic message. I found =
that it was due to dma allocation function call particularly =
dma_alloc_coherent() of tsi108_open function. When we see the =
implementation of dma_alloc_coherent. It was bit changed from the =
previous linux versions it seems.=20
        The implementation of dma_alloc_coherent was kept on the =
arch/powerpc/include/asm/dma-mapping.h file. Earlier implementation is =
not considering the first parameter what the tsi108 driver is passing as =
NULL. But the current implementation is considering this parameter and =
because of this the panic is coming what i believe.

        So kindly let me know any patches for this problem or any fixes.
  Regards,
  T.


-------------------------------------------------------------------------=
-----


  _______________________________________________
  Linuxppc-dev mailing list
  Linuxppc-dev@lists.ozlabs.org
  https://lists.ozlabs.org/listinfo/linuxppc-dev
------=_NextPart_000_00B7_01CA2196.55E9B0F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6001.18000" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi all,</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I found=20
that the header file(dma-mapping.h)&nbsp;has changed. I saw this change =
has=20
happened on Linux -2.6.28 kernel onwards. earlier kernel is having=20
COMFIT_PPC64&nbsp;macro. Based&nbsp;on this macro the things were=20
happened.&nbsp;Is there any fixes available right now or any reasons =
behind this=20
changes. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Regards,<BR>T.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dthirumalai.p@datapatterns.co.in=20
  href=3D"mailto:thirumalai.p@datapatterns.co.in">Thirumalai =
Pachamuthu</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinuxppc-dev@ozlabs.org=20
  href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Thursday, August 20, 2009 =
9:45=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Regarding TSI108 =
ethernet DMA=20
  issue</DIV>
  <DIV><BR></DIV>
  <DIV>Hi all,</DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am trying to port linux 2.6.30 =
for my=20
  TSI108 based custom board where i am getting the following kernel =
panic=20
  message. I found that it was due to dma allocation function call =
particularly=20
  dma_alloc_coherent() of tsi108_open function. When we see the =
implementation=20
  of dma_alloc_coherent. It was bit changed from the previous linux =
versions it=20
  seems. </DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The implementation of =
dma_alloc_coherent=20
  was kept on the arch/powerpc/include/asm/dma-mapping.h file. Earlier=20
  implementation is not considering the first parameter what the tsi108 =
driver=20
  is passing as NULL. But the current implementation is considering this =

  parameter and because of this the panic is coming what i =
believe.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So kindly let me know any patches =
for this=20
  problem or any fixes.</DIV>
  <DIV>Regards,</DIV>
  <DIV>T.</DIV>
  <P>
  <HR>

  <P></P>_______________________________________________<BR>Linuxppc-dev =
mailing=20
  =
list<BR>Linuxppc-dev@lists.ozlabs.org<BR>https://lists.ozlabs.org/listinf=
o/linuxppc-dev</BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00B7_01CA2196.55E9B0F0--
