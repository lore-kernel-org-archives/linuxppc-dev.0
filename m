Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F09CAB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 16:53:00 +1100 (EST)
Message-ID: <1331185951.3105.29.camel@pasglop>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 08 Mar 2012 16:52:31 +1100
In-Reply-To: <20120308145131.fad50bbc79c36f0b0b12d101@canb.auug.org.au>
References: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
 <25744.1331174036@neuling.org>
 <20120308145131.fad50bbc79c36f0b0b12d101@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-03-08 at 14:51 +1100, Stephen Rothwell wrote:
> Hi Mikey,
> 
> On Thu, 08 Mar 2012 13:33:56 +1100 Michael Neuling <mikey@neuling.org> wrote:
> >
> > Surely we only need SPARSE_IRQ now and not MAY_HAVE_SPARSE_IRQ.  
> > 
> > In fact, keeping MAY_HAVE_SPARSE_IRQ seems to make SPARSE_IRQ user
> > selectable, which we don't want anymore since ad5b7f1350c2.
> 
> Yes, indeed. I will fix up the merge resolution for tomorrow.

This is my fault. Grant's patch had a collision and I manually fixed it
up. While doing that, I put back MAY_HAVE_SPARSE_IRQ which the patch
originally took out.

Cheers,
Ben.
