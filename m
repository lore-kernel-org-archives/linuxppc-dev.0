Return-Path: <mst@mellanox.co.il>
Received: from mtlexch01.mtl.com (unknown [194.90.237.34])
	by ozlabs.org (Postfix) with ESMTP id 37A7D67A04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 03:00:45 +1000 (EST)
Date: Tue, 9 May 2006 19:49:19 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509164919.GC5063@mellanox.co.il>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adalktbcgl1.fsf@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting r. Roland Dreier <rdreier@cisco.com>:
> The trivial way to do it would be to use the same idea as the current
> ehca driver: just create a thread for receive CQ events and a thread
> for send CQ events, and defer CQ polling into those two threads.

For RX, isn't this basically what NAPI is doing?
Only NAPI seems better, avoiding interrupts completely and avoiding latency hit
by only getting triggered on high load ...

-- 
MST
