Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB8A9DDFA1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 00:44:06 +1000 (EST)
Message-Id: <F0A35B8E-13E3-46D5-BB32-5BE14C0A878F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200804101346.32376.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
Date: Thu, 10 Apr 2008 09:44:01 -0500
References: <200804101346.32376.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2008, at 6:46 AM, Laurent Pinchart wrote:
> Hi Paul,
>
> could you please add the following patches ?
>
> [PATCHv4 1/5] cpm_uart: Allocate DPRAM memory for SMC ports on CPM2- 
> based
> platforms.
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053858.html
>
> [PATCHv4 2/5] powerpc: Add bootwrapper function to get virtual reg  
> from the
> device tree.
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053859.html
>
> [PATCHv4 3/5] cpm-serial: Relocate CPM buffer descriptors and SMC  
> parameter
> ram.
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053860.html
>
> [PATCHv4 4/5] ep8248e: Reference SMC parameter RAM base in the  
> device tree.
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053862.html
>
> [PATCHv4 5/5] cpm2: Reset the CPM when early debugging is not enabled.
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/053861.html

Your patches still have mailer issues when I try to apply them.

If you want to go back and forth privately so we can figure out what's  
going on.

- k
