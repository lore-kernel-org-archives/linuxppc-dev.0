Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA03FDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 00:38:46 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1ODcgSA001914
	for <linuxppc-embedded@ozlabs.org>; Sun, 24 Feb 2008 08:38:42 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1ODcgVY227734
	for <linuxppc-embedded@ozlabs.org>; Sun, 24 Feb 2008 08:38:42 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1ODcgn3016017
	for <linuxppc-embedded@ozlabs.org>; Sun, 24 Feb 2008 08:38:42 -0500
Date: Sun, 24 Feb 2008 07:38:00 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Albrecht =?UTF-8?B?RHJlw58=?= <albrecht.dress@arcor.de>
Subject: Re: Status of 5200B and 440 Kernel Support
Message-ID: <20080224073800.4bdb30ac@zod.rchland.ibm.com>
In-Reply-To: <1203848259l.2313l.1l@antares.localdomain>
References: <1203848259l.2313l.1l@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 24 Feb 2008 11:17:39 +0100
Albrecht Dre=C3=9F <albrecht.dress@arcor.de> wrote:

> For a decision, I need some further information about the Kernel =20
> support (source code available, if possible in stock kernels, *not* =20
> only vendor binary modules!) of the included devices, in particular

For 440EP in arch/powerpc:

> - MTD/NAND controller

NOR flash works.  NAND needs some additional code.

> - Ethernet

Works.

> - UART, IIC and SPI

UART works.  IIC has recent patches.  No idea about SPI.

> - USB host

Works.

> - local external bus (not PCI) DMA

DMA to the EBC for what?

josh
