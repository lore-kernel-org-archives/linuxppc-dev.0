Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3885EDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 07:43:19 +1000 (EST)
In-Reply-To: <20070820145836.3fd8af11.sfr@canb.auug.org.au>
References: <20070820145836.3fd8af11.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b6a8df562f181284195a2fedfccd5dc5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] iSeries: clean up lparmap mess
Date: Mon, 20 Aug 2007 23:43:05 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We need to have xLparMap in ead_64.S so that it is at a fixed address

+h

> (because the linker will not resolve (address & 0xffffffff) for us).
> But the assembler miscalculates the KERNEL_VSID() expressions.  So put
> the confusing expressions into asm-offset.c.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Looks just fine.  It puts some stuff into head that doesn't
really belong there, but it sort-of was there already anyway ;-)

Nice cleanup no matter what, great :-)

> Segher: this was plan C  :-)

Your plan C, my plan F :-)


Segher
