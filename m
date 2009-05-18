Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58975DE06B
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:52:56 +1000 (EST)
Subject: Re: [PATCH]  bug fix in arch/powerpc/mm/tlb_nohash_low.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090518154721.0a9c3dee.sfr@canb.auug.org.au>
References: <1242622146.31702.26.camel@torez.austin.ibm.com>
	<1242623523.18075.39.camel@pasglop>
	<20090518154721.0a9c3dee.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 18 May 2009 15:52:34 +1000
Message-Id: <1242625954.18075.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-18 at 15:47 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Mon, 18 May 2009 15:12:03 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Thanks, but it's been fixed already :-)
> > 
> > See commit b62c31ae401c6df25c61b206681a6e904ef97169.
> 
> Should this be submitted for 2.6.29 stable?

Probably, will do.

Cheers,
Ben.
