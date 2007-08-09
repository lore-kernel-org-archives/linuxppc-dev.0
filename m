Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B5CEBDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 16:11:49 +1000 (EST)
Date: Wed, 08 Aug 2007 23:11:44 -0700 (PDT)
Message-Id: <20070808.231144.22645124.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [PATCH 0/1] lro: Generic Large Receive Offload for TCP traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708031441.14780.ossthema@de.ibm.com>
References: <200708031441.14780.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com,
	gallatin@myri.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Fri, 3 Aug 2007 14:41:14 +0200

> I think this patch could be the final version for now. It has been tested
> on two platforms (power and x86_64) and works very well.

I checked in the LRO patch and the two sample driver ports
to net-2.6.24, thanks!
