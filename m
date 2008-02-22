Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AE65DDF5B
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 05:33:37 +1100 (EST)
In-Reply-To: <20080222095022.GA635@ingate.macqel>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
Date: Fri, 22 Feb 2008 12:33:19 -0600
To: Philippe De Muyter <phdm@macqel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 22, 2008, at 03:50, Philippe De Muyter wrote:

> Dear list,
>
> I have just compiled linux-2.6.24 for a MPC8540 target using a MPC8540
> specific gcc.
>
> I then got tan infinity of "SPE used in kernel" messages.  Looking  
> at the
> sources I ifdeffed out the printk call in KernelSPE, and I now have a
> silent kernel, that seems to work fine.
>
> Is there something wrong in my setting and should I look further to
> debug this problem or is this perfectly normal ?
>
> I wonder why a kernel configured for E500 and compiled by a E500- 
> specific gcc
> triggers this message.  Is it invalid to use SPE instructions in  
> the kernel
> or do I misunderstand the message ?


We don't currently support using SPE in the kernel.  Are you using  
SPE in the kernel for some reason?  Do you think that the compiler is  
automatically generating SPE code in the kernel?  I've never seen  
that before.

Andy
