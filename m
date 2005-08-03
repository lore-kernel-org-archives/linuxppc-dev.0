Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E6EC567E51
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 04:24:15 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA91127964158494B1@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA91127964158494B1@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ABAA88EF-CF28-485E-8179-5EB2B8E2501A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 3 Aug 2005 13:24:15 -0500
To: "Bizhan Gholikhamseh \\((bgholikh\\))" <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8541E DMA transfer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I dont see any reason you couldn't use the internal DMA engine on the  
MPC8541E to do what you need.  You will just need to schedule the  
work every 10ms.

- kumar

On Aug 3, 2005, at 10:04 AM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

>
> Hi all,
> I am developing a linux driver (2.6.10) for Freescale MPC8541E
> (customized board) to read and write 8 buffers (each buffer is 960  
> bytes
> long) every 10 ms to/from a custom made PCI card with on board DSP  
> Chip.
> The chip's internal and external memories are memory mapped to the CPU
> address space.
> For reason that is beyond the discussion here, the DMA request line on
> the PCI card is not connected although the PCI card has DMA
> capabilities.
> So what are my options?
> Could I still do DMA transfer from the Host to the device?
>
> Many thanks in advance,
> Bizhan
>
> <ATT293768.txt>
>
