Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9E7AFDDE1D
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 19:40:13 +1000 (EST)
Date: Sun, 15 Jul 2007 02:40:15 -0700 (PDT)
Message-Id: <20070715.024015.126137834.davem@davemloft.net>
To: hch@infradead.org
Subject: Re: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070715091253.GA15790@infradead.org>
References: <200707111621.24852.ossthema@de.ibm.com>
	<20070714.235748.02297780.davem@davemloft.net>
	<20070715091253.GA15790@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 15 Jul 2007 10:12:53 +0100

> I'm not sure that's a good idea.  If current chips can't handle ipv6
> lro there is no way to actually test it and the code will surely bitrot.

Christoph, you can do LRO pretty much completely in software.
