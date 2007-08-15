Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F256FDE060
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 16:48:39 +1000 (EST)
Date: Tue, 14 Aug 2007 23:48:36 -0700 (PDT)
Message-Id: <20070814.234836.74729446.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [POWERPC] Remove get_property and device_is_compatible
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070815164515.44233b66.sfr@canb.auug.org.au>
References: <20070815164515.44233b66.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 15 Aug 2007 16:45:15 +1000

> They were only needed for backwards compatibility and all in tree uses
> have now been changed.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Thanks for doing this Stephen.
