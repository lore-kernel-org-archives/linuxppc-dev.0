Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 0024A2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 05:44:02 +1000 (EST)
Date: Sun, 14 Apr 2013 15:43:58 -0400 (EDT)
Message-Id: <20130414.154358.755597670486116198.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH 0/3] freescale: Update logging style
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1365915548.git.joe@perches.com>
References: <cover.1365915548.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Sat, 13 Apr 2013 22:03:16 -0700

> Convert various printk logging styles to current styles.
> 
> Uncompiled, untested.
> 
> Joe Perches (3):
>   fec: Convert printks to netdev_<level>
>   gianfar: Use netdev_<level> when possible
>   ucc_geth: Convert ugeth_<level> to pr_<level>

All applied.
