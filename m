Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CF28DDF10
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 08:28:39 +1000 (EST)
Message-Id: <F7E012CB-5062-496D-BECC-4B9EAFBD4D75@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
In-Reply-To: <20080923195404.GA10935@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
Date: Tue, 23 Sep 2008 17:28:25 -0500
References: <20080923195404.GA10935@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 2:54 PM, Sebastian Siewior wrote:

> this could be used by the kexec userland code.
>
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
> This is done by the 64bit kexec code allready. The 32bit doesn't use  
> the
> device tree at all. I'm not sure whether the node has to be a 32bit or
> 64bit value.
>
> arch/powerpc/boot/main.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)

I missing why you are doing this?  Do you plan on using it w/32-bit  
kexec?

- k
