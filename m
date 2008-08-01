Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3215BDE027
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 17:04:19 +1000 (EST)
Date: Fri, 01 Aug 2008 00:04:17 -0700 (PDT)
Message-Id: <20080801.000417.85699799.davem@davemloft.net>
To: joerg.roedel@amd.com
Subject: Re: [PATCH] Revert "Merge branch 'x86/iommu' of
	git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip into
	for-linus"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080801070328.GA26894@amd.com>
References: <20080801094323.9601d87b.sfr@canb.auug.org.au>
	<20080801085106E.fujita.tomonori@lab.ntt.co.jp>
	<20080801070328.GA26894@amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
	jbarnes@virtuousgeek.org, fujita.tomonori@lab.ntt.co.jp,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joerg Roedel <joerg.roedel@amd.com>
Date: Fri, 1 Aug 2008 09:03:28 +0200

> That may be the reason that your fix is not yet upstream.

The reason is more-so because Linus simply hasn't merged more
than a couple of patches since 2.6.27-rc1 was released.
