Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33FFC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 13:46:34 +1100 (EST)
Date: Sat, 20 Oct 2012 21:52:34 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
Message-ID: <20121021015234.GE25828@titan.lakedaemon.net>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <5028D040.60604@codethink.co.uk> <502D201E.9030304@codethink.co.uk>
 <201209101422.13875.arnd@arndb.de>
 <1347343411.2603.42.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347343411.2603.42.camel@pasglop>
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, ben.dooks@codethink.co.uk,
 Ian Molton <ian.molton@codethink.co.uk>, dale@farnsworth.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pong.  ;-)

On Tue, Sep 11, 2012 at 04:03:31PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-10 at 14:22 +0000, Arnd Bergmann wrote:
> > Following up on the old discussion, I talked briefly about this
> > issue with BenH at the kernel summit. The outcome basically is that
> > it's a bit sad to have incompatible bindings, but it's not the end
> > of the world,and it's more important to do it right this time.
> > 
> > Just make sure that you use different values for the 'compatible'
> > strings and then do what you need to get the ARM hardware working.
> > 
> > Ideally, the new binding should be written in a way that powerpc
> > machines can use the same one, but the existing ones all use
> > an version of Open Firmware that is not going to get updated
> > and it's also not too likely that we are going to see new
> > powerpc machines based on this chip.
> 
> Right, mostly these machines where the Pegasos. Those came with a fairly
> busted variant of Open Firmware which generated a pretty gross
> device-tree.
> 
> For some reason, the manufacturer of those things was never willing to
> fix anything in their firmware (despite the distributor providing
> patches etc...), seemingly on the assumption that whatever they were
> doing was perfect and operating system people like us didn't matter one
> little bit :-)
> 
> So I don't care much about it. It would be nice to keep them working
> since people in the community still have them but if it goes through
> some "compat" code that detects old/broken device-trees and eventually
> disappears when we finally drop support, then so be it.

Ian,

What is the status of this work?

thx,

Jason.
