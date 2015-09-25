Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 8B2F51A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 16:05:27 +1000 (AEST)
Date: Thu, 24 Sep 2015 23:05:22 -0700 (PDT)
Message-Id: <20150924.230522.2080343670036893514.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: linux@arm.linux.org.uk, thomas.petazzoni@free-electrons.com,
 devicetree@vger.kernel.org, sgoutham@cavium.com, rric@kernel.org,
 frowand.list@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com,
 netdev@vger.kernel.org, soren.brinkmann@xilinx.com, isubramanian@apm.com,
 grant.likely@linaro.org, leoli@freescale.com, kchudgar@apm.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <5604A5EC.7060401@gmail.com>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <5604A5EC.7060401@gmail.com>
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

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 24 Sep 2015 18:39:56 -0700

> On 24/09/15 12:17, Russell King - ARM Linux wrote:
>> Hi,
>> 
>> The third version of this series fixes the build error which David
>> identified, and drops the broken changes for the Cavium Thunger BGX
>> ethernet driver as this driver requires some complex changes to
>> resolve the leakage - and this is best done by people who can test
>> the driver.
>> 
>> Compared to v2, the only patch which has changed is patch 6
>>   "net: fix phy refcounting in a bunch of drivers"
>> 
>> I _think_ I've been able to build-test all the drivers touched by
>> that patch to some degree now, though several of them needed the
>> Kconfig hacked to allow it (not all had || COMPILE_TEST clause on
>> their dependencies.)
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thanks for fixing that.

Series applied, thanks.
