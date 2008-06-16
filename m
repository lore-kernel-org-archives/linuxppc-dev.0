Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75203DDF69
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 19:05:38 +1000 (EST)
Subject: Re: BUG() in current git, __dma_alloc_coherent, Beige G3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joseph Fannin <jfannin@gmail.com>
In-Reply-To: <20080616073041.GA26917@nineveh.local>
References: <20080616014615.GA8960@nineveh.local>
	<1213591838.8129.123.camel@pasglop>
	<20080616073041.GA26917@nineveh.local>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 19:05:28 +1000
Message-Id: <1213607128.8129.129.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-16 at 03:30 -0400, Joseph Fannin wrote:
> I think it's because PPC_PRPMC2800 and MPC5121_ADS both live under
> PPC_MULTIPLATFORM, and end up selecting NOT_COHERENT_CACHE.
> 
> If the button in Kconfig isn't labeled "Do Not Push", heck, I'll build
> it.

Heh, ok, disable those then.

Cheers,
Ben.
