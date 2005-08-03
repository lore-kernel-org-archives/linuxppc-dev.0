Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 958FE67DFE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 04:27:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 3 Aug 2005 11:26:52 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494B8@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8541E DMA transfer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there any support in Linux 2.6.X for using this controller, if so,
are you aware of any test driver I can take a look at?

Thanks,
Bizhan

Many thanks in =20

-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Wednesday, August 03, 2005 11:24 AM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8541E DMA transfer

I dont see any reason you couldn't use the internal DMA engine on the
MPC8541E to do what you need.  You will just need to schedule the work
every 10ms.

- kumar

On Aug 3, 2005, at 10:04 AM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

>
> Hi all,
> I am developing a linux driver (2.6.10) for Freescale MPC8541E=20
> (customized board) to read and write 8 buffers (each buffer is 960=20
> bytes
> long) every 10 ms to/from a custom made PCI card with on board DSP=20
> Chip.
> The chip's internal and external memories are memory mapped to the CPU

> address space.
> For reason that is beyond the discussion here, the DMA request line on

> the PCI card is not connected although the PCI card has DMA=20
> capabilities.
> So what are my options?
> Could I still do DMA transfer from the Host to the device?
>
> Many thanks in advance,
> Bizhan
>
> <ATT293768.txt>
>
