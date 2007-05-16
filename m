Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D082DDEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 02:44:54 +1000 (EST)
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02 hardware
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1179247809.8132.138.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
Content-Type: text/plain
Message-Id: <1179333883.7018.20.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 16 May 2007 11:44:43 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:50, Wade Farnsworth wrote:
> +static void __devinit early_mpc86xx_pcie(struct pci_dev *dev)
> +{
> +	   dev->class = PCI_CLASS_BRIDGE_PCI << 8 | 0x1;
> +}

What'd we decide on that 0x1 in there?

Thanks,
jdl
