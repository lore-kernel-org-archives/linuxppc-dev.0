Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 30CF7DDF09
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 13:00:13 +1000 (EST)
Date: Thu, 15 May 2008 20:00:06 -0700 (PDT)
Message-Id: <20080515.200006.06776414.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] [POWERPC] move of_device_get_modalias fo drivers/of
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080516115745.efb998fb.sfr@canb.auug.org.au>
References: <20080516115745.efb998fb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulua@samba.org, olaf@aepfle.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 16 May 2008 11:57:45 +1000

> Commit 140b932f8cb6cced10b96860651a198b1b89cbb9 ("Create modalias file
> in sysfs for of_platform bus") needs this to avoid breaking the sparc
> builds.
> 
> Just move the code and add whitespace around some binary operators.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
