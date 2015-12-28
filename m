Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 4A73C1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 13:14:11 +1100 (AEDT)
Date: Sun, 27 Dec 2015 21:14:03 -0500 (EST)
Message-Id: <20151227.211403.242539822762320022.davem@davemloft.net>
To: igal.liberman@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 stephen@networkplumber.org, afleming@gmail.com, knneth@gmail.com
Subject: Re: [v10, 0/6] Freescale DPAA FMan
From: David Miller <davem@davemloft.net>
In-Reply-To: <1450657290-6644-1-git-send-email-igal.liberman@freescale.com>
References: <1450657290-6644-1-git-send-email-igal.liberman@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: <igal.liberman@freescale.com>
Date: Mon, 21 Dec 2015 02:21:24 +0200

> The Freescale Data Path Acceleration Architecture (DPAA) is a set
> of hardware components on specific QorIQ multicore processors.
> This architecture provides the infrastructure to support
> simplified sharing of networking interfaces and accelerators
> by multiple CPU cores and the accelerators.
> 
> One of the DPAA accelerators is the Frame Manager (FMan)
> which contains a series of hardware blocks: ports, Ethernet MACs,
> a multi user RAM (MURAM) and Storage Profile (SP).
> 
> This patch set introduce the FMan drivers.
> Each driver configures and initializes the corresponding
> FMan hardware module (described above).
> The MAC driver offers support for three different
> types of MACs (eTSEC, TGEC, MEMAC).

Series applied, thanks.
