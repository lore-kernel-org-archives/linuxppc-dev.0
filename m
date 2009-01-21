Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DCEFBDDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 09:46:04 +1100 (EST)
Date: Wed, 21 Jan 2009 14:46:06 -0800 (PST)
Message-Id: <20090121.144606.230078300.davem@davemloft.net>
To: tklein@de.ibm.com
Subject: Re: [PATCH 2/3] ehea: Fix mem allocations which require page alignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <200901211549.21066.tklein@de.ibm.com>
References: <200901211549.21066.tklein@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	hering2@de.ibm.com, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Thomas Klein <tklein@de.ibm.com>
Date: Wed, 21 Jan 2009 15:49:20 +0100

> PAGE_SIZE allocations via slab are not guaranteed to be page-aligned. Fixed
> all memory allocations where page alignment is required by firmware.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>

Applied.
