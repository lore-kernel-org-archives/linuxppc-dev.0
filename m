Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6F80688D6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 07:43:03 +1100 (EST)
Date: Mon, 19 Dec 2005 14:38:19 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <43A6ED1E.20506@anagramm.de>
Message-ID: <Pine.LNX.4.44.0512191437460.4403-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.15-rc5-latest doesn't work anymore on mpc8540ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 19 Dec 2005, Clemens Koller wrote:

> Hello!
> 
> Here is a little update:
> 
> > I am just about to update my kernel from 2.6.13-rc7 which is working
> > fine to linus' 2.6.15-rc5-latest git on my mpc8540ads flavored board.
> > However, the kernel hangs pretty early after
> > 
> > openpic: exit
> 
> openpic_init() is called by mpc85xx_ads_init_IRQ in ppc/platforms/85xx
> 
> ppc_md.init_IRQ=mpc85xx_ads_init_IRQ in ppc/platforms/85xx
> 
> ppc_md.init_IRQ() is called from powerpc/kernel/irq.c
> 
> init_IRQ() is  called from init/main.c:start_kernel()
> 
> and that seems to work fine. So, it crashes silently somewhere
> after that point. I try to build 2.6.15-rc6-latest with kgbd support,
> not knowing if it's supposed to work on this platform.

It was a guess :)
 
> Are there some open issues from the ppc->powerpc migration?

possible, can you use git bisect to find what commit may have caused the 
issue?

- kumar
