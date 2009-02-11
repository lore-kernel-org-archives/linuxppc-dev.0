Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0EA30DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:48:14 +1100 (EST)
Date: Wed, 11 Feb 2009 13:48:07 -0800 (PST)
Message-Id: <20090211.134807.77169123.davem@davemloft.net>
To: hannes.hering@linux.vnet.ibm.com
Subject: Re: [PATCH] ehea: Fix: Remove adapter from adapter list in error path
From: David Miller <davem@davemloft.net>
In-Reply-To: <200902111329.02954.hannes.hering@linux.vnet.ibm.com>
References: <200902111329.02954.hannes.hering@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2009 13:29:02 +0100

> Remove adapter from adapter list before freeing data structure in error path.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>

Applied to net-next-2.6, thanks!
