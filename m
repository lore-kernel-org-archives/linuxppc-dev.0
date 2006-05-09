Return-Path: <mst@mellanox.co.il>
Received: from mtlexch01.mtl.com (unknown [194.90.237.34])
	by ozlabs.org (Postfix) with ESMTP id 8DE4467A62
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 06:20:00 +1000 (EST)
Date: Tue, 9 May 2006 23:20:41 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt
	handling	routines
Message-ID: <20060509202041.GB24713@mellanox.co.il>
References: <40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de>
	<OF6CAB9865.804CAFBB-ON87257169.006C3DBC-88257169.00718277@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6CAB9865.804CAFBB-ON87257169.006C3DBC-88257169.00718277@us.ibm.com>
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
> My understanding is NAPI handle interrutps CQ callbacks on the same CPU.

My understanding is NAPI disables interrupts under high RX load. No?

-- 
MST
