Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A3877B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 17:57:28 +1100 (EST)
Date: Wed, 07 Mar 2012 22:53:17 -0800 (PST)
Message-Id: <20120307.225317.837723066642024990.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 2/7] net: powerpc: remove the legacy iSeries ethernet
 driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120308153353.ee2ff35c8ebe7ee66fa374e9@canb.auug.org.au>
References: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
 <20120308153353.ee2ff35c8ebe7ee66fa374e9@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 8 Mar 2012 15:33:53 +1100

> This driver is specific to the PowerPC legcay iSeries platform which is
> being removed.
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: <netdev@vger.kernel.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
