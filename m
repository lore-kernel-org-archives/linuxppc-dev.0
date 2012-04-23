Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09111B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 06:22:41 +1000 (EST)
Message-ID: <1335212556.21619.24.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc/mpic: Fix confusion between hw_irq and virq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Apr 2012 06:22:36 +1000
In-Reply-To: <20120423173228.BA05A3E089A@localhost>
References: <1334892574.31646.0.camel@pasglop>
 <20120423173228.BA05A3E089A@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-23 at 11:32 -0600, Grant Likely wrote:
> On Fri, 20 Apr 2012 13:29:34 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > mpic_is_ipi() takes a virq and immediately converts it to a hw_irq.
> > 
> > However, one of the two call sites calls it with a ... hw_irq. The
> > other call site also happens to have the hw_irq at hand, so let's
> > change it to just take that as an argument. Also change mpic_is_tm()
> > for consistency.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Looks good to me.  Are you pushing these up to Linus for v3.4?

Already did :-)

Cheers,
Ben.
