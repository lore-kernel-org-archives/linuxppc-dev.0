Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 29EF5DDFAC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 02:54:57 +1100 (EST)
Subject: __pa(dma_alloc_coherent()) doesn't give physical address
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C759BE.7506DCA9"
Date: Mon, 26 Feb 2007 16:54:53 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E682C13@aquib01a>
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

------_=_NextPart_001_01C759BE.7506DCA9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

dma_alloc_coherent gives a kernel virtual address as a return address,
applying __pa I expected a physical address.
It doesn't happen, I receive an address far beyond my 16 MB ram.
Applying virt_to_bus doesn't give a physical address too.
OK, you can resort to dma_addr_t parameter of dma_alloc_coherent but is
there a reason for __pa not working on a kernel virtual address?
=20
=20
=20
Bye,
Antonio.

------_=_NextPart_001_01C759BE.7506DCA9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D606374515-26022007>dma_alloc_coherent=20
gives a kernel virtual address as a return address, applying __pa I =
expected a=20
physical address.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D606374515-26022007>It =
doesn't happen, I=20
receive an address far beyond my 16 MB ram. Applying virt_to_bus doesn't =
give a=20
physical address too.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D606374515-26022007>OK, =
you can resort=20
to dma_addr_t parameter of dma_alloc_coherent but is there a reason for =
__pa not=20
working on a kernel virtual address?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D606374515-26022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D606374515-26022007></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D606374515-26022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D606374515-26022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D606374515-26022007>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D606374515-26022007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C759BE.7506DCA9--
