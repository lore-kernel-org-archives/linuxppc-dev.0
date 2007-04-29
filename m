Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36C28DDF7D
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 17:49:58 +1000 (EST)
Date: Sun, 29 Apr 2007 00:43:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] Rename get_property to of_get_property: drivers/net
Message-Id: <20070429004348.ea30f3fc.akpm@linux-foundation.org>
In-Reply-To: <20070428.204754.62343452.davem@davemloft.net>
References: <20070427145508.9c5641a2.sfr@canb.auug.org.au>
	<4633689E.50900@garzik.org>
	<20070429114446.31f40a30.sfr@canb.auug.org.au>
	<20070428.204754.62343452.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, paulus@samba.org,
	jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Apr 2007 20:47:54 -0700 (PDT) David Miller <davem@davemloft.net> wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Sun, 29 Apr 2007 11:44:46 +1000
> 
> > So can I take this as a future OK for architecture specific network
> > drivers changes to go through the architecture trees (cc'd to you)?
> 
> It's been my experience that if I'm just working through some
> platform or bus specific API changes, people like Jeff tend to
> not mind if it goes via ARCH trees and the like.

This all started with me having a dummyspit over yet another huge reject
because of intersections between subsystem trees.

Normally we get away with it but when there's so much material pending,
things deteriorate.
