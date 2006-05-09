Return-Path: <mst@mellanox.co.il>
Received: from mtlexch01.mtl.com (unknown [194.90.237.34])
	by ozlabs.org (Postfix) with ESMTP id EBF9567A5C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:44:09 +1000 (EST)
Date: Tue, 9 May 2006 21:44:52 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
Message-ID: <20060509184451.GF22825@mellanox.co.il>
References: <20060509164919.GC5063@mellanox.co.il>
	<OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting r. Shirley Ma <xma@us.ibm.com>:
> According to some results from different resouces, NAPI only gives 3%-10% performance improvement on single CQ.

When you say performance you mean bandwidth.
But I think it should improve the CPU utilization on RX side significantly.
If it does, that an important metric as well.

> I am trying a simple NAPI patch on splitting CQ now to see how much performance there.

What are you using for a benchmark?

-- 
MST
