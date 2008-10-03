Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C0D8DE281
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 02:58:09 +1000 (EST)
Message-ID: <48E64E94.3080807@freescale.com>
Date: Fri, 03 Oct 2008 11:55:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: liran raz <liranrazlinux@gmail.com>
Subject: Re: NOHZ: local_softirq_pending 08
References: <e3b3ab5c0810030940l3100e494id6b4fcdec71991a7@mail.gmail.com>
In-Reply-To: <e3b3ab5c0810030940l3100e494id6b4fcdec71991a7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

liran raz wrote:
> hi,
> I have a driver that uses the scc1 intertupts.
> After enabling the scc1 interrupts I see this message
> coming from the kernel for some time:
> NOHZ: local_softirq_pending 08
> 1. What is the meaning of this message? does
> 2. Does it indicate that something is wrong & need a fix?
> 3. How can I get rid of it?
> (The interrupt is connected to an ISR by using
> the standard request_irq() routine).
> Kernel 2.6.24
> Processor: MPC8272
> Thanks,
> Liran.

The error comes from generic timer code; I'd test with the latest kernel 
and then ask on the linux-kernel list.

-Scott
