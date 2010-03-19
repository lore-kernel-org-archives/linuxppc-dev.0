Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13E13B7D2F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 12:37:00 +1100 (EST)
Subject: Re: [PATCH 4/6] powerpc: Rename LWSYNC_ON_SMP to
	PPC_RELEASE_BARRIER, ISYNC_ON_SMP to PPC_ACQUIRE_BARRIER
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20100319010813.GF25636@laptop>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100319010813.GF25636@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Mar 2010 12:36:53 +1100
Message-ID: <1268962613.8599.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-19 at 12:08 +1100, Nick Piggin wrote:
> > -     ISYNC_ON_SMP
> > +     PPC_ACQUIRE_BARRIER
> 
> I wonder if this shouldn't be called PPC_ISYNC_ACQUIRE_BARRIER ?
> 
> Unlike PPC_RELEASE_BARRIER, it is not an acquire barrier unless it
> is used like an isync.

Right. The semantic of isync would be more something like
PPC_IFETCH_BARRIER or similar :-)

Cheers,
Ben.
