Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 05C3EDDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:21:27 +1000 (EST)
Date: Thu, 19 Jul 2007 20:21:26 -0700 (PDT)
Message-Id: <20070719.202126.59466393.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 08/12] Begin to consolidate of_device.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070720011612.cc101b92.sfr@canb.auug.org.au>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011612.cc101b92.sfr@canb.auug.org.au>
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
Date: Fri, 20 Jul 2007 01:16:12 +1000

> This moves all the common parts for the Sparc, Sparc64 and PowerPC
> of_device.c files into drivers/of/device.c.
> 
> Apart from the simple move, Sparc gains of_match_node() and a call to
> of_node_put in of_release_dev().  PowerPC gains better recovery if
> device_create_file() fails in of_device_register().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.
