Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60224DE1F2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:37:53 +1000 (EST)
Message-Id: <53AF5414-9FDD-4B74-9369-9F6F717D7FDA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080701130438.GA25531@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/86xx: mpc8610_hpcd: fix interrupt trigger type
	for ULi IDE
Date: Wed, 2 Jul 2008 02:37:45 -0500
References: <20080701130438.GA25531@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 1, 2008, at 8:04 AM, Anton Vorontsov wrote:

> i8259 PIC is disabled on MPC8610HPCD, and ULi IDE is configured to use
> PCI sideband interrupt that is specified in the device tree.
>
> Current HPCD's device tree specify that IDE interrupt is low to high
> sensitive, but in practice ULi IDE throws active-high interrupts (not
> active-low as all normal PCI devices).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> This is for -next, since the bug could be triggered only on RT kernels
> with hardirq preemption.

applied.

- k
