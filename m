Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 447F067B79
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:32:52 +1000 (EST)
Date: Wed, 16 Aug 2006 16:32:52 -0700 (PDT)
Message-Id: <20060816.163252.64000941.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060816233028.GO20551@austin.ibm.com>
References: <20060816.143203.11626235.davem@davemloft.net>
	<200608170016.47072.arnd@arndb.de>
	<20060816233028.GO20551@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, arnd@arndb.de, jeff@garzik.org, netdev@vger.kernel.org,
	jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 16 Aug 2006 18:30:28 -0500

> Why would you want o do this? It seems like a cruddier strategy 
> than what we can already do  (which is to never get an transmit
> interrupt, as long as the kernel can shove data into the device fast
> enough to keep the queue from going empty.)  The whole *point* of a 
> low-watermark interrupt is to never have to actually get the interrupt, 
> if the rest of the system is on its toes and is supplying data fast
> enough.

As long as TX packets get freed within a certain latency
boundary, this kind of scheme should be fine.
