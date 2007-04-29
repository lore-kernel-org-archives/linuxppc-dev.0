Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B78AFDDF6F
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 13:47:46 +1000 (EST)
Date: Sat, 28 Apr 2007 20:47:54 -0700 (PDT)
Message-Id: <20070428.204754.62343452.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 2/2] Rename get_property to of_get_property: drivers/net
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070429114446.31f40a30.sfr@canb.auug.org.au>
References: <20070427145508.9c5641a2.sfr@canb.auug.org.au>
	<4633689E.50900@garzik.org>
	<20070429114446.31f40a30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 29 Apr 2007 11:44:46 +1000

> So can I take this as a future OK for architecture specific network
> drivers changes to go through the architecture trees (cc'd to you)?

It's been my experience that if I'm just working through some
platform or bus specific API changes, people like Jeff tend to
not mind if it goes via ARCH trees and the like.
