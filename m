Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 564A2DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 09:34:57 +1000 (EST)
Date: Tue, 24 Apr 2007 16:35:03 -0700 (PDT)
Message-Id: <20070424.163503.58438848.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 24 Apr 2007 22:32:45 +1000

> This creates drivers/openfw/base.c (depending on CONFIG_OPENFW) and puts
> the first trivially common bits from the prom.c files into it.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

All 6 patches look great to me.  Thanks Stephen.

I've been trying to think about how to ease the merging of
all of this stuff since it touches a bunch of platforms.

I'm happy to take care of all of this stuff in my sparc-2.6.22 GIT
tree at:

	master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.22.git

which I just rebased, if the PPC folks are fine with this.

If agreed, please just send over the PPC driver et al. patches from
the powerpc tree (ie. the get_property() renaming bits) and I'll suck
them into my sparc-2.6.22 tree.

If not agreed, we do have to come up with some kind of merge plan :-)
