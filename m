Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A70A667AB8
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 00:41:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050125224248.276080b7.davem@davemloft.net>
References: <1106028614.4533.69.camel@gaston>
	<20050125224248.276080b7.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 00:40:47 +1100
Message-Id: <1106746848.5235.54.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sungem update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > If you are happy with this, please forward to Linus/Andrew asap
> 
> Sorry for taking so long.  I'll try to quick review and sanity
> test this on my sparc sungem chips tomorrow Ben.

Thanks. There is no real hurry as the bulk of the powermac PM updates
won't make it until 2.6.12 anyway, so feel free to comment. I know I
still take too much locks for too long, and I do intend to fix that,
though the fact that set_multicast is called with a lock doesn't quite
help here ... :) Hopefully, this new version makes the whole stuff more
simple tho and easier to follow.

Ben.
