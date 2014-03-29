Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id A5C611400B5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Mar 2014 09:20:59 +1100 (EST)
Date: Sat, 29 Mar 2014 18:20:54 -0400 (EDT)
Message-Id: <20140329.182054.1947915200276978934.davem@davemloft.net>
To: B45475@freescale.com
Subject: Re: [PATCH v2] phy/at8031: enable at8031 to work on interrupt mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <1395992381-23094-1-git-send-email-B45475@freescale.com>
References: <1395992381-23094-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mugunthanvnm@ti.com, B07421@freescale.com, netdev@vger.kernel.org,
 helmut.schaa@googlemail.com, linux-kernel@vger.kernel.org, zonque@gmail.com,
 R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhao Qiang <B45475@freescale.com>
Date: Fri, 28 Mar 2014 15:39:41 +0800

> The at8031 can work on polling mode and interrupt mode.
> Add ack_interrupt and config intr funcs to enable
> interrupt mode for it.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> changes for v2:
> 	- when interrupt is not enabled, write 0 to interrupt enbale register
> 	- delete a inner parens not needed

Applied to net-next, thanks.
