Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67FB5DDF43
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:06:11 +1000 (EST)
Subject: Re: [PATCH] Add StorCenter DTS first draft.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1184795678.25235.269.camel@localhost.localdomain>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<1184722754.25235.183.camel@localhost.localdomain>
	<5F6EB5F7-C5AE-437F-9DF1-22FE38D7A841@kernel.crashing.org>
	<1184795678.25235.269.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1184861129.16820.2.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Jul 2007 11:05:29 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 16:54, Benjamin Herrenschmidt wrote:

> Cache line size is used by the kernel on ppc64 for things like clearing
> memory (to get the stride between subsequent dcbz) or flushing the
> cache :-) It's also passed on to userland.
> 
> If it's absent from the device-tree, we default to the values in the
> cputable, but if you're going to put the properties in the tree, don't
> put a 0 in there. As it is, the day I make the 64 bits code common, your
> DT will break unless I special case "0".
> 
> Ben.

So, just to put this issue to rest some, I have
modified my DTS to have correct values here.
It was _easy_. ;-)

But, a followup patch should clean up _other_, existing
DTS files that have 0 there still.

jdl
