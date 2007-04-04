Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BF559DDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:48:04 +1000 (EST)
Date: Tue, 03 Apr 2007 18:48:04 -0700 (PDT)
Message-Id: <20070403.184804.35358780.davem@davemloft.net>
To: david.lang@digitalinsight.com
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
References: <20070403.181645.68159458.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu>
	<Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Lang <david.lang@digitalinsight.com>
Date: Tue, 3 Apr 2007 18:07:06 -0700 (PDT)

> I've seen machines offering up to 48, what's the magic number that makes you 
> need to chagne nameing schemes?

Yep, excellent point.
