Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 14BD7B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 06:29:46 +1000 (EST)
Date: Mon, 11 Apr 2011 13:29:09 -0700 (PDT)
Message-Id: <20110411.132909.232734437.davem@davemloft.net>
To: bhutchings@solarflare.com
Subject: Re: [PATCH net-next-2.6 1/2] gianfar: Clean up implementation of
	RX network flow classification
From: David Miller <davem@davemloft.net>
In-Reply-To: <1302306311.2871.56.camel@bwh-desktop>
References: <1302306311.2871.56.camel@bwh-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ben Hutchings <bhutchings@solarflare.com>
Date: Sat, 09 Apr 2011 00:45:11 +0100

> This code was cribbed from niu, so gfar_set_hash_opts() begins by
> converting the ethtool flow class code into a class code for Sun
> Neptune hardware, then does the same thing again for the hardware it's
> really dealing with.  It may also return -1 (-EPERM) for some
> unhandled ethtool flow class codes.
> 
> Remove the useless code and definitions, and fix the error code.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
> This isn't even compile-tested, since it can only be built for some
> PowerPC SoCs.  Could someone on ppc-dev check that this won't break the
> driver?

I'm applying this, it looks so trivial to me that I'm willing to take
the build risk :-)

Thanks.
