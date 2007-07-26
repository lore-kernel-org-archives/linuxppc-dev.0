Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 25EA2DDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 10:28:14 +1000 (EST)
Date: Wed, 25 Jul 2007 17:28:13 -0700 (PDT)
Message-Id: <20070725.172813.03082027.davem@davemloft.net>
To: gallatin@myri.com
Subject: Re: [RFC 0/1] lro: Generic Large Receive Offload for TCP traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <46A785C2.9090708@myri.com>
References: <200707201741.45079.ossthema@de.ibm.com>
	<46A785C2.9090708@myri.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com,
	meder@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andrew Gallatin <gallatin@myri.com>
Date: Wed, 25 Jul 2007 13:17:54 -0400

> I've ported myri10ge to use the new LRO interface.  I have attached a
> preliminary patch to myri10ge.  I'm very pleased to note that the
> performance is on-par with my own LRO used by our out-of-tree driver.
> (except when using mixed MTUS, see performance data below).

Thanks for posting this port and feedback on the generic LRO
code.
