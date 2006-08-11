Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9EB7C67B5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 13:40:23 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7B4wh9D004317 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 22:58:43 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7B3eIpW014974
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 22:40:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI driver on EB8347
Date: Fri, 11 Aug 2006 11:40:17 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
In-Reply-To: <4DA89577C33E194ABEBC978921E858541B8E38@exchange.ingenient.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "rajan rai" <Rajan.Rai@ingenient.com>,
	"Gala Kumar K.-galak" <kumar.gala@freescale.com>
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


Rajan>        I have written PCI driver which works fine along with
MPC8347 and two PCI
Rajan> card connected in a single PCI bus. When I try to communicate
same PCI card
Rajan> using PCI bridge ( PCI2050B ), Linux does detect PCI card on
Secondary bus=20
Rajan> but same driver doesn't work !!!!

PCI interrupt for secondary bus set up properly?
     =20
Rajan>        Do I need to enable support for second PCI host controller
at kernel level to=20
Rajan>make it work? Or I need to do something else ? I tried compiling
PPC-linux kernel
Rajan> after enabling CONFIG_85xx_PCI2 kernel doesn't compile it gives
me error while=20
Rajan>compiling "arch/ppc/syslib/ppc83xx_setup.c" Kernel version I'm
using is 2.6.13.

Why you enable CONFIG_85xx_PCI2 in kernel? It is for 85xx, but you are
using 8347 processor.

<snip>

Dave
