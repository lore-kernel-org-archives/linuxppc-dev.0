Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09E00DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 01:22:24 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 15 Nov 2007 15:21:41 +0100
References: <200711151430.05943.jbe@pengutronix.de>
	<BLU106-W38B9242918AC024D3BEBB6CA820@phx.gbl>
In-Reply-To: <BLU106-W38B9242918AC024D3BEBB6CA820@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711151521.43047.jbe@pengutronix.de>
Subject: Re: MPC5200B: Linux does not recognise the external PCI card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 15 November 2007 14:49, Pedro Luis D. L. wrote:
> > [...]
> > PCI: Probing PCI hardware
> > PCI: device 0000:00:18.0 has unknown header type 7f, ignoring.
> > mpc52xx_pci_fixup_resources() 1057:5809
> > [...]
> >
> > and does not show the external card:
>
> Which card?

Its a NEC USB 2.0 card.

> Is its driver supported by the kernel?

I think so.

> Is it enabled inside the kernel image?

But until the card gets recognised it makes no sense to play with the driver.

> Did you add the PCI bridge in platform configuration file? I
> suppose so if there is a PCI probing test. I added an external ethernet
> device and had no problem to made it work with 2.6.22 kernel.

My kernel is a 2.6.23.1

Juergen
