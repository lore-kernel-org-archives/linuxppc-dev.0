Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4EB767A82
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Feb 2005 11:25:56 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050226112832.GA10300@suse.de>
References: <1106011958.4533.25.camel@gaston> <20050226112832.GA10300@suse.de>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 11:24:43 +1100
Message-Id: <1109463883.14993.170.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-02-26 at 12:28 +0100, Olaf Hering wrote:
>  On Tue, Jan 18, Benjamin Herrenschmidt wrote:
> 
> 
> > +++ linux-work/arch/ppc/platforms/pmac_cache.S	2005-01-18 12:01:49.000000000 +1100
> 
> > +	b	__flush_disable_L1
> 
> This one is only available for CONFIG_6xx, so g5 32bit users will
> scream. (not that I care)

Me neither :) I don't support g5 32 bits, though I'll probably just fix
it for this time as it's easy. 

> arch/ppc/platforms/built-in.o(.text+0x1228): In function `flush_disable_caches':
> : undefined reference to `__flush_disable_L1'
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
