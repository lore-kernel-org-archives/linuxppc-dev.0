Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82F6A679EF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 03:11:19 +1000 (EST)
In-Reply-To: <1116261725.5095.139.camel@gaston>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
	<1116261725.5095.139.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22b73f109d1c4a95b565f1007d76b8bf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 13:11:21 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2005, at 12:42 PM, Benjamin Herrenschmidt wrote:

> On the other hands, how many embedded boards care about getting the
> latest "linus" tree ?

Why are you PMac guys always treating the embedded boards
as second class citizens?  Don't any of you remember that all of
initial PowerPC work was done on an embedded board and the PMac
was a beneficiary of that work? :-)

Of course we care the "linus" tree is up to date.  We use that
all of the time for new product development.  If it wasn't for so few
of us having permission to write updates, we would probably register
many more than you do.

> ...  Embedded code has been rather frozen in
> the rock, I don't think it's much to ask from the appropriate 
> maintainer
> to have a quick look at possibly upgrading their board support as well.

It's not frozen, it's just more tedious because we are trying to find
solutions that are commonly good for everyone, not demanding
changes and forcing everyone else to adapt.

> And it isn't a difficult change for most 6xx/7xx/7xxx based boards
> anyway. What I'm worried about is that without some "pressure" (like
> breaking them), it will simply never be fixed...

Who cares?  We have the ability to support the memory map flexibility
for everyone.  If you need it, use it, and fix it if necessary.  There 
are
too many other things that need attention.  Again, you are taking one
of the features we added for embedded boards a long time ago, and
demanding everyone support it.  That's not necessary.   If you want
to use this feature on a PMac, then use it, but please don't demand
everyone else do so.  We didn't do that when the feature was added.

> The whole io_block_mapping() was a bad idea in the first place.

All of the ideas in 2.6 are going to look like bad ideas in the future 
:-)
It's what worked and was necessary given the lack of any other
APIs at the time.  We are working on removing these in the embedded
boards, and it has to be done on the PMac as well if you want to
take advantage of something other than a 2G task space.

As time permits, I will make whatever changes to the board ports
I'm aware of so they will accommodate a 3G task space, or fix up
the configuration files so the default is 2G.  At some point, we can
make it the configuration default.

Thanks.


	-- Dan
