Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC088DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:26:03 +1100 (EST)
Subject: Re: [PATCH 4/16] ps3: system bus minor mmio fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BE4BD8.4050701@am.sony.com>
References: <45BAC20A.8040107@am.sony.com>
	<1169928417.24996.205.camel@localhost.localdomain>
	<20070128084239.GA6311@lst.de>  <45BE4BD8.4050701@am.sony.com>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 07:16:01 +1100
Message-Id: <1170101761.26655.266.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-29 at 11:32 -0800, Geoff Levand wrote:
> Christoph Hellwig wrote:
> > On Sun, Jan 28, 2007 at 07:06:57AM +1100, Benjamin Herrenschmidt wrote:
> >> Note that I personally think that drivers/ps3 is a very wrong place for
> >> the ps3 system bus. It should stay in arch/powerpc/platform/ps3
> > 
> > Yes, absolutely.  We should not spreads things all over the tree do
> > make understanding the code even more difficult than all the lv1
> > braindamage already makes it.
> 
> I'm really disappointed that you both feel that way.  Why didn't you say so several
> months ago when I first posted that?  

I overlooked it. It's not the end of the world, easy enough to move
them. Sorry about that.

> I also don't think it is a good place, since
> I need to expose a bunch of platform specifics in asm-powerpc/ps3.h, which would
> better stay in my platform/ps3/platform.h.  When I had that stuff in the platform
> directory there was criticism that it shouldn't go there, so I moved it out.  I'll
> make a patch for RFC and see what happens.

Ben.
