Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06330DE209
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:35:07 +1100 (EST)
Message-Id: <A5C9DECB-0DD8-4ADE-AC4D-0B2801B54F57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matteo Fortini <m.fortini@selcomgroup.com>
In-Reply-To: <48EF5A94.3070707@selcomgroup.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: kernel 2.6.27 MPC512x status
Date: Fri, 10 Oct 2008 09:35:02 -0500
References: <48EF5A94.3070707@selcomgroup.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 8:37 AM, Matteo Fortini wrote:

> I gave a try to the brand new 2.6.27 kernel on my ADS5121 evaluation  
> board:
>
>   * FEC support is not in, though it was quite easy to add FSL patches
>     from 2.6.24.6 and have the ethernet working
>   * If I turn on any USB support, the board resets itself as soon as
>     the USB driver is loaded. Without USB, I can get to a prompt.
>     Funny that the software reset is not working, but this bug is
>     actually able to sw reset the board...
>   * PCI seems not to be working, but I need to test it more. The fact
>     that FSL needed to patch 2.6.24.6 in order to get PCI working
>     makes me think it's needs some work.
>
> This is bad because I wanted to incorporate some newer patches, like  
> the PWM one, but kernel 2.6.24.6 is too backward in time, while  
> 2.6.27 is too forward for FSL patches...

I've applied some 3 patches from John Ribgy to add 5121 PCI support.   
These are intended for .28, but should be clean against .27.

They are:
powerpc/fsl: Hide MPC5121 pci bridge.
powerpc: 83xx: pci: Remove need for get_immrbase from  
mpc83xx_add_bridge.
powerpc/5121: Add PCI support.

And can be found in:

	git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

- k
