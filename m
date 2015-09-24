Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 0A26D1A0D2D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 08:15:58 +1000 (AEST)
Date: Thu, 24 Sep 2015 15:15:54 -0700 (PDT)
Message-Id: <20150924.151554.619662567057050978.davem@davemloft.net>
To: andrew@lunn.ch
Cc: linux@arm.linux.org.uk, f.fainelli@gmail.com,
 thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org,
 sgoutham@cavium.com, rric@kernel.org, frowand.list@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, michal.simek@xilinx.com, netdev@vger.kernel.org,
 soren.brinkmann@xilinx.com, isubramanian@apm.com, grant.likely@linaro.org,
 leoli@freescale.com, kchudgar@apm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150924215731.GE20825@lunn.ch>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <20150924215731.GE20825@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 24 Sep 2015 23:57:31 +0200

> I built the FEC driver as a module, and it won't unload:
> 
>  kernel:unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> 
> i assume because DSA holds a reference. I've not tried a fully module
> build, DSA has issues with that.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

So, is this a regression?

Please don't provide a "Tested-by: " tag is you encounter a new
problem which could have been introduced by the changes in question.
That _REALLY_ screws everything up for me.

Thank.
