Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A1BA2DDF8B
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 07:42:45 +1000 (EST)
Date: Thu, 12 Apr 2007 14:42:46 -0700 (PDT)
Message-Id: <20070412.144246.26987903.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [SPARC/64] Remove get_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070403230505.f96ea210.sfr@canb.auug.org.au>
References: <20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
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
Date: Tue, 3 Apr 2007 23:05:05 +1000

> All the usages have been renamed to of_get_property.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
 ...
> If you take the curent powerpc tree (commit
> 1b56c1da9eec35c610fa2168d754ce567615a6ee) and apply all the patches I
> sent today (1-6 then 1-17) then merge that with your current for-2.6.22
> tree (commit ab571e3091f055b0f8648822e11ee6413993f899), then you can
> apply this.  :-)
> 
> I did a test sparc64 allmodconfig build (and it get as far as can be
> expected :-))

Yikes, this is getting messy :-)

We will have some staging issues during the 2.6.22 merge window.

For now why don't I leave this one out of my tree and you can
just put it into the powerpc tree which eliminated all of
the instances of get_property()?

Thanks.
