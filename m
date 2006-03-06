Return-Path: <brian@waitefamily.us>
Received: from irobot.com (brick.irobot.com [66.238.211.199])
	by ozlabs.org (Postfix) with ESMTP id D4CAA67B62
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 00:33:28 +1100 (EST)
From: Brian Waite <brian@waitefamily.us>
To: linuxppc-embedded@ozlabs.org,
 Phil.Nitschke@avalon.com.au
Subject: Re: linux DMA capabilities in MV64460
Date: Mon, 6 Mar 2006 08:21:29 -0500
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
	<kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
In-Reply-To: <kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603060821.29220.brian@waitefamily.us>
Reply-To: brian@waitefamily.us
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm now looking seriously (and reluctantly!) at writing a DMA Controller
> Driver to supplement these functions, and I've started the process of
> getting an NDA from Marvell, so I can get their User Manual (and errata!).
>
You won't get very far without the user manual, then I think you will find it 
pretty easy to write the driver with the frameworks already in the kernel.
> Can someone point me in the right direction to get me started?  I need
> to come up the learning curve to find out where to start.
>
> How is a DMA controlled (from a device driver writer's perspective) when
> a third-party (i.e. in the bridge) DMA controller needs to do the work
> to get the data from a PCI Target into main memory?
>
> What kernel API should be provided by the DMA Controller Driver?
>
My first guess would be to follow something like Documentation/DMA-API.txt and 
Documentation/DMA-mapping.txt

> Any documentation, examples, similar device drivers, etc, would be
> appreciated.  TIA,
You could look to followup that by groking arch/ppc/kernel/dma-mapping.c
Finally, arch/ppc/syslib ppc4xx_dma.c seems to show an example of a low level 
driver. 
I didn't notice any platform dma controllers like MAG reccommended, but that 
should be a better way to go. 

Thanks
Brian
