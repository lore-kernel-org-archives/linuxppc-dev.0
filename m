Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 1937D67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 19:28:35 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5RAjR4j027746 for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 04:45:27 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5R9SURd010455
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 04:28:32 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306D93192@zch01exm40.ap.freescale.net>
From: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
To: Florian Boelstler <euphoria@arcor.de>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Tue, 27 Jun 2006 17:28:26 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> Is there a publicly available source for patches to the current BSP?
> Are there any other PCIe-related fixes?

It's an add-on PCIe patch. We have tested it on MPC8641, but we have no PCIe-PCI bridge on MPC8548 platform to do more test. So if you verify it, I'll commit it. :)

> 
> Best regards,
> 
>    Florian
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
