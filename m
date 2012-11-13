Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 98E592C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 06:44:12 +1100 (EST)
Date: Tue, 13 Nov 2012 14:44:06 -0500 (EST)
Message-Id: <20121113.144406.1610017702502358739.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH] wanrouter: Remove it and the drivers that depend on it
From: David Miller <davem@davemloft.net>
In-Reply-To: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jcmvbkbc@gmail.com,
 harryxiyou@gmail.com, paulus@samba.org, linux@arm.linux.org.uk, richard@nod.at,
 linux-xtensa@linux-xtensa.org, rob@landley.net,
 user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
 xiyoulinuxkernelgroup@googlegroups.com,
 user-mode-linux-user@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, isdn@linux-pingi.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 linux-kernel@zh-kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Sat, 10 Nov 2012 06:20:55 -0800

> Remove wanrouter as it's obsolete and has not been updated
> by sangoma since 2.4.3 or so and it's not used anymore.
> 
> Remove obsolete cyclomx drivers.
> Update defconfig files that enable wanrouter.
> Update files that include now deleted wanrouter bits.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I'm fine with this change, except the arch defconfig bits.

We've been leaving those alone, and letting the arch maintainers
do the updates themselves periodically.

Please resubmit this with those parts removed.

Thanks.
