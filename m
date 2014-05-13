Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id D7D54140096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 07:44:53 +1000 (EST)
Date: Tue, 13 May 2014 17:43:45 -0400 (EDT)
Message-Id: <20140513.174345.406760552060437774.davem@davemloft.net>
To: w-lkml@lebenslange-mailadresse.de
Subject: Re: [PATCH] [resend] net: get rid of SET_ETHTOOL_OPS
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140511001231.GC7875@kaos.lebenslange-mailadresse.de>
References: <20140511001231.GC7875@kaos.lebenslange-mailadresse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, trivial@kernel.org,
 xen-devel@lists.xenproject.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, e1000-devel@lists.sourceforge.net,
 bridge@lists.linux-foundation.org, devel@linuxdriverproject.org,
 nios2-dev@lists.rocketboards.org, dev@openvswitch.org,
 linuxppc-dev@lists.ozlabs.org, linux-acenic@sunsite.dk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wilfried Klaebe <w-lkml@lebenslange-mailadresse.de>
Date: Sun, 11 May 2014 00:12:32 +0000

> net: get rid of SET_ETHTOOL_OPS
> 
> Dave Miller mentioned he'd like to see SET_ETHTOOL_OPS gone.
> This does that.
> 
> Mostly done via coccinelle script:
> @@
> struct ethtool_ops *ops;
> struct net_device *dev;
> @@
> -       SET_ETHTOOL_OPS(dev, ops);
> +       dev->ethtool_ops = ops;
> 
> Compile tested only, but I'd seriously wonder if this broke anything.
> 
> Suggested-by: Dave Miller <davem@davemloft.net>
> Signed-off-by: Wilfried Klaebe <w-lkml@lebenslange-mailadresse.de>

Applied to net-next, thanks.
