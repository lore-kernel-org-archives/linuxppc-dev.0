Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F53EDDDFA
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 13:18:35 +1100 (EST)
Subject: Re: [PATCH 1/1] irq: Maintain user set affinity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
In-Reply-To: <86802c440811081601w2be45e55hc400095137831b85@mail.gmail.com>
References: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
	<86802c440811081412u6d54beaam143801ce83225f40@mail.gmail.com>
	<1226182645.13603.90.camel@pasglop>
	<86802c440811081601w2be45e55hc400095137831b85@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 09 Nov 2008 13:17:39 +1100
Message-Id: <1226197059.13603.92.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> for MSI, affinity is set two times.
> 
> also in dynamic_irq_init is setting with
> #ifdef CONFIG_SMP
>         cpus_setall(desc->affinity);
> #endif
> 
> it seems should use irq_default_affinity instead of CPU_MASK_ALL directly there.

That sounds more like it.

Cheers,
Ben.
