Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A954BB6FDB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 17:57:33 +1100 (EST)
Date: Wed, 07 Mar 2012 22:53:01 -0800 (PST)
Message-Id: <20120307.225301.360050313988337392.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 0/7] powerpc: remove the legacy iSeries platform
 specific drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
References: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, JBottomley@parallels.com,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 8 Mar 2012 15:28:53 +1100

> It would probably be easiest if all these patches were merged via the
> powerpc tree to eliminate any dependencies between them.  Their impact on
> generic code is very small.

No objections.
