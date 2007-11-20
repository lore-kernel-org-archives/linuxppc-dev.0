Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F02BDDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 17:08:33 +1100 (EST)
Subject: Re: [patch] powerpc: hash lock use lock bitops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20071120050950.GB18332@wotan.suse.de>
References: <20071120050826.GA18332@wotan.suse.de>
	<20071120050950.GB18332@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 17:08:24 +1100
Message-Id: <1195538904.6970.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-20 at 06:09 +0100, Nick Piggin wrote:
> This isn't a bugfix, but may help performance slightly...
> 
> --
> powerpc 64-bit hash pte lock bit is an actual lock, so it can take advantage
> of lock bitops for slightly more optimal memory barriers (can avoid an lwsync
> in the trylock).
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Looks nice, I'll try it out on a G5 and let you know.

Cheers,
Ben.
