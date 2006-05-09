Return-Path: <mst@mellanox.co.il>
Received: from mtlexch01.mtl.com (unknown [194.90.237.34])
	by ozlabs.org (Postfix) with ESMTP id E5A7867A65
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:54:51 +1000 (EST)
Date: Tue, 9 May 2006 21:55:33 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Subject: Re: Re: [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509185533.GG22825@mellanox.co.il>
References: <20060509184451.GF22825@mellanox.co.il>
	<OF9332FF11.38007290-ON87257169.00673F71-88257169.006C7F6E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF9332FF11.38007290-ON87257169.00673F71-88257169.006C7F6E@us.ibm.com>
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
> No, CPU utilization wasn't reduced. When you use single CQ, NAPI polls on both RX/TX.

I think NAPI's point is to reduce the interrupt rate.
Wouldn't this reduce CPU load?

> netperf, iperf, mpstat, netpipe, oprofiling, what's your suggestion?

netperf has -C which gives CPU load, which is handy.
Running vmstat in another window also works reasoably well.

-- 
MST
