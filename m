Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 55811DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 18:31:02 +1100 (EST)
Date: Wed, 12 Nov 2008 23:31:01 -0800 (PST)
Message-Id: <20081112.233101.132837068.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/4] Add helpers for finding a device node which as a
	certain property
From: David Miller <davem@davemloft.net>
In-Reply-To: <1226560303.7856.38.camel@localhost>
References: <20081112.224648.106631825.davem@davemloft.net>
	<1226558945.7856.27.camel@localhost>
	<1226560303.7856.38.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Nov 2008 18:11:43 +1100

> With my compiler (4.3.1) it just gets inlined and actually makes the
> text 8 bytes larger. We might be using different CFLAGs to sparc though.
> 
> I didn't think it made the source significantly clearer to split out the
> of_find_property() logic, especially seeing as we don't need the lenp
> behaviour in of_find_node_with_property().

Fair enough.
