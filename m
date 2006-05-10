Return-Path: <mst@mellanox.co.il>
Received: from mtlexch01.mtl.com (unknown [194.90.237.34])
	by ozlabs.org (Postfix) with ESMTP id E5CD6679EA
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 15:32:58 +1000 (EST)
Date: Wed, 10 May 2006 08:33:41 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Shirley Ma <xma@us.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt
	handling	routines
Message-ID: <20060510053341.GI22825@mellanox.co.il>
References: <20060509202041.GB24713@mellanox.co.il>
	<OFD1053717.15B4F49A-ON87257169.007531E1-88257169.007AD29E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFD1053717.15B4F49A-ON87257169.007531E1-88257169.007AD29E@us.ibm.com>
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
> Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling?routines
> 
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> wrote on 05/09/2006 01:20:41 PM:
> 
> > Quoting r. Shirley Ma <xma@us.ibm.com>:
> > > My understanding is NAPI handle interrutps CQ callbacks on the same CPU.
> >
> > My understanding is NAPI disables interrupts under high RX load. No?
> 
> Yes, NAPI disables the interrupts based on the weight. In IPoIB case, it doesn't
> send out the next completion notification under heavy loading.
> The similiar CQ polling is still in NAPI on same CPU, but it's not a callback
> anymore.

Sorry, same CPU as what?

-- 
MST
