Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A5B6ADDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 18:57:27 +1100 (EST)
Date: Thu, 02 Apr 2009 00:57:15 -0700 (PDT)
Message-Id: <20090402.005715.02030593.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 0/3] Series short description
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090401060117.8641.32252.stgit@localhost.localdomain>
References: <20090401060117.8641.32252.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 01 Apr 2009 00:16:46 -0600

> Here are the fec_mpc52xx patches which should be picked up for 2.6.29.
> Patch #1 fixes a dma related BUG_ON() discovered after the merge window
> opened.  #2 & #3 were original a single patch posted prior to the merge
> window, but not having a s-o-b line from the original author held them up.
> In the end I rewrote it from scratch as two patches just so I can get
> them merged.  #2 makes the driver use net_device_ops, and #3 fixes a NULL
> dereference.
> 
> I've tested these patches on several MPC5200 platforms.

All applied, thanks Grant.
