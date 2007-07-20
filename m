Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C60A6DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:12:59 +1000 (EST)
Date: Thu, 19 Jul 2007 20:12:58 -0700 (PDT)
Message-Id: <20070719.201258.25911887.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 07/12] Consolidate of_find_node_by routines
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070720011450.d0b97300.sfr@canb.auug.org.au>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011450.d0b97300.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	wli@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:14:50 +1000

> This consolidates the routines of_find_node_by_path, of_find_node_by_name,
> of_find_node_by_type and of_find_compatible_device.  Again, the comparison
> of strings are done differently by Sparc and PowerPC and also these add
> read_locks around the iterations.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.
