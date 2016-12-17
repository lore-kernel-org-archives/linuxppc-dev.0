Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tgssr6g9gzDw9J
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 03:22:56 +1100 (AEDT)
Date: Sat, 17 Dec 2016 11:22:46 -0500 (EST)
Message-Id: <20161217.112246.248943325874592041.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] dpaa_eth: a couple of fixes 
From: David Miller <davem@davemloft.net>
In-Reply-To: <1481807586-4798-1-git-send-email-madalin.bucur@nxp.com>
References: <1481807586-4798-1-git-send-email-madalin.bucur@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Thu, 15 Dec 2016 15:13:03 +0200

> This patch set introduces big endian accessors in the dpaa_eth driver
> making sure accesses to the QBMan HW are correct on little endian
> platforms. Removing a redundant Kconfig dependency on FSL_SOC.
> Adding myself as maintainer of the dpaa_eth driver.

Series applied, thanks.
