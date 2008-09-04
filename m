Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23171DDFB6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 08:37:06 +1000 (EST)
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1220492616.3254.64.camel@localhost.localdomain>
References: <1220473137.3254.29.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
	<1220481754.3254.42.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031546310.3515@nehalem.linux-foundation.org>
	<1220482853.3254.47.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031602270.3515@nehalem.linux-foundation.org>
	<1220484812.3254.59.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031636320.3515@nehalem.linux-foundation.org>
	<1220492616.3254.64.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 08:36:51 +1000
Message-Id: <1220567811.4879.85.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Parisc List <linux-parisc@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Make dereference_function_descriptor() more accommodating by allowing
> architecture overrides.  I put the three overrides (for parisc64, ppc64
> and ia64) in arch/kernel/module.c because that's where the kernel
> internal linker which knows how to deal with function descriptors sits.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
