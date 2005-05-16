Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABD75679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 01:52:33 +1000 (EST)
In-Reply-To: <1116255938.5095.133.camel@gaston>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 11:52:38 -0400
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


On May 16, 2005, at 11:05 AM, Benjamin Herrenschmidt wrote:

> I suppose it would add about ... 1 instruction :)

It's a little more than that :-)

> But I agree that we don't abolutely _need_ to break everybody. Maybe a
> better compromise would be to have the default beeing per CPU family ?
> 6xx/7xx/7xxx could default to 3G and 8xx stay at 2G...

That's still going to break nearly every embedded board.  My point is
that is all configurable for each individual board, so if you want that 
to
be the default for a board, then just update the defconfig for that 
board.
The PMac is only one "board" out of many we support, and I don't think
it should be considered the default or generic configuration any more
than any other board.  The PMac is the easiest to update because it's
a single configuration file.  If you want that to have a 3G default task
space, then update that one configuration file.  As we have time we
will update all of the others, and when we get to the point where most
boards are of that configuration, we'll make it the default and the
minority of boards become the special cases.

Thanks.


	-- Dan
