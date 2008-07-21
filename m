Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9861DDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 11:38:59 +1000 (EST)
Subject: Re: [patch] powerpc: implement pte_special for 64K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080720181658.02651e2f.akpm@linux-foundation.org>
References: <20080717104426.GA25083@wotan.suse.de>
	<1216601875.11027.59.camel@pasglop>
	<20080720181658.02651e2f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 11:27:18 +1000
Message-Id: <1216603638.11027.67.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-20 at 18:16 -0700, Andrew Morton wrote:
> On Mon, 21 Jul 2008 10:57:55 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Thu, 2008-07-17 at 12:44 +0200, Nick Piggin wrote:
> > > This can be folded into powerpc-implement-pte_special.patch
> > > 
> > > --
> > > Ben has now freed up a pte bit on 64k pages. Use it for special pte bit.
> > > 
> > > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > > ---
> > 
> > Ack.
> > 
> > Andrew, will you merge this or do you want me to ?
> 
> I can do so.

Thanks.

Cheers,
Ben.
