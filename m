Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 215A6DDE46
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 02:35:00 +1000 (EST)
In-Reply-To: <1182529202.29873.7.camel@ld0161-tx32>
References: <1180996227.9632.77.camel@ld0161-tx32>
	<062E6779-8D69-4700-896C-FE06A5F8947E@kernel.crashing.org>
	<1182529202.29873.7.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FDC9C77C-01D4-4F4D-B843-BC2056494564@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 9/9] Created quirk_mpc8641_transparent() to initialize
	bridge resources.
Date: Fri, 22 Jun 2007 11:35:45 -0500
To: Jon Loeliger <jdl@freescale.com>
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


On Jun 22, 2007, at 11:20 AM, Jon Loeliger wrote:

> On Fri, 2007-06-22 at 08:50, Kumar Gala wrote:
>
>> Shouldn't we put this in fsl_pcie.c since it will be need by everyone
>> using an 85xx/86xx pci-e controller?
>
>> - k
>
> IIRC, Ww are trying to eliminate the need for fsl_pcie.c
> and converge on the more generic code instead.
> If we can ever get the PCI-E patches accepted, the
> 8641 boards won't use the fsl_pcie.c file at all. :-)

Where do we plan on putting the freescale generic pci code?

- k
