Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B28D0DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 08:43:34 +1000 (EST)
Date: Mon, 30 Jul 2007 15:43:32 -0700 (PDT)
Message-Id: <20070730.154332.72713181.davem@davemloft.net>
To: jeff@garzik.org
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <46AE0F36.8030605@garzik.org>
References: <200707301724.33865.ossthema@de.ibm.com>
	<46AE0F36.8030605@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	gallatin@myri.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeff Garzik <jeff@garzik.org>
Date: Mon, 30 Jul 2007 12:17:58 -0400

> David, thoughts on merging?  I'm not We could stick this into your tree 
> or mine.  Whether yours or mine, I would like to keep the driver and 
> net-core patches together in the same git tree.

No objections and I'll stick it into my net-2.6.24 tree once I cut
that, I'll have the NAPI stuff in there too so I'll keep these two
merge nightmares out of your hair :-)
