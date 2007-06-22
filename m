Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ADCADDDFB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 02:20:11 +1000 (EST)
Subject: Re: [PATCH v2 9/9] Created quirk_mpc8641_transparent() to
	initialize bridge resources.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <062E6779-8D69-4700-896C-FE06A5F8947E@kernel.crashing.org>
References: <1180996227.9632.77.camel@ld0161-tx32>
	<062E6779-8D69-4700-896C-FE06A5F8947E@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1182529202.29873.7.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 22 Jun 2007 11:20:02 -0500
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-22 at 08:50, Kumar Gala wrote:

> Shouldn't we put this in fsl_pcie.c since it will be need by everyone  
> using an 85xx/86xx pci-e controller?

> - k

IIRC, Ww are trying to eliminate the need for fsl_pcie.c
and converge on the more generic code instead.
If we can ever get the PCI-E patches accepted, the
8641 boards won't use the fsl_pcie.c file at all. :-)

jdl
