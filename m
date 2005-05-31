Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 17F86679A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 01:17:34 +1000 (EST)
In-Reply-To: <429B2B54.1060504@anagramm.de>
References: <429B2B54.1060504@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5be2f8f42a2cfaea381a88c5de9cbb4e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 31 May 2005 10:17:25 -0500
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Complete ccsr map for mpc8540 available?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 30, 2005, at 10:03 AM, Clemens Koller wrote:

> Hi, There!
>
> I want to access the local bus controller (LBC) registers
> of the mpc8540 from within a module.
> Therefore I want to use similar structures as for the 8560's cpm2_immr
> or the 8xx. However, I was not able to find a complete ccsr map for the
> mpc8540 in the 2.6.11.x kernels. (immap_85xx.h, 8xx_immr.h, ...)
>
> Can someone point me to get the memc_brx / orx and friends for mpc8540?
> (the complete CCSR map.) Or some code to recycle?
> Or do I need to patch more into immap_85xx.h on my own? I just want to
> avoid to do duplicate work.
>
> Or is it better to extend the fsl_ocp or the platform device 
> structures?

What do you plan on doing with the local bus controller in the kernel?  
If this is only configuration of the controller for a given chip select 
that I would suggest doing something similar to how we handle PCI.  You 
can probably find a description of the localbus registers in the u-boot 
source tree.

Is this a change you want to get back into the mainline kernel tree?

- kumar
