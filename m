Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8DAC1B7D8C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 07:06:55 +1000 (EST)
Date: Wed, 16 Jun 2010 14:07:06 -0700 (PDT)
Message-Id: <20100616.140706.48510350.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 2/2] of: kill struct of_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100604211138.2762.35074.stgit@angua>
References: <20100604205930.2762.17131.stgit@angua>
	<20100604211138.2762.35074.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Jun 2010 15:11:38 -0600

> Now that the device tree node pointer has been moved out of struct
> of_device and into the common struct device, there isn't anything
> unique about of_device anymore.  In fact, there isn't much need
> for a separate of_bus when all busses have access to OF style
> probing.
> 
> arch/powerpc and arch/microblaze are moving away from using the of_bus
> and using the regular platform bus instead for mmio devices.  This
> patch makes of_device the same as platform_device as a stepping stone
> in migrating of_platform_drivers over to the platform bus.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
