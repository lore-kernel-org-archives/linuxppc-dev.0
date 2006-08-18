Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 095DA67B98
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 00:21:25 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Outstanding Patches Ping 
In-Reply-To: Your message of "Fri, 18 Aug 2006 10:07:47 +1000."
	<17637.1235.223857.925995@cargo.ozlabs.ibm.com>
References: <1155679316.10054.129.camel@cashmere.sps.mot.com>
	<17636.3393.801267.484874@cargo.ozlabs.ibm.com>
	<E1GDhtO-0002Mk-2j@jdl.com>
	<17637.1235.223857.925995@cargo.ozlabs.ibm.com>
Date: Fri, 18 Aug 2006 09:21:16 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GE5Do-0000XJ-UM@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Paul Mackerras mumbled:
> 
> The "Allow MPC8641 HPCN to build with CONFIG_PCI disabled too" patch
> depends on your "Rewrite the PPC 86xx IRQ handling to use Flat Device
> Tree" which isn't in the queue for 2.6.18, and doesn't apply for
> 2.6.18 since it depends on the constifying of get_property.

Argh!  That IRQ rewrite patch is the critical patch to get into 2.6.18
as it is currently totally broken without it, and works with it!
Any chance?  I mean, it was working in the early -rc versions of .18
before Ben changed the IRQ world.  This is just cleanup effort to
have it continue to work in in .18.

jdl
