Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 15301B70AA
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 06:03:46 +1000 (EST)
Date: Fri, 23 Jul 2010 13:04:02 -0700 (PDT)
Message-Id: <20100723.130402.232759717.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] of: make of_find_device_by_node generic
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100723200217.18363.48627.stgit@angua>
References: <20100723200217.18363.48627.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jonas@southpole.se, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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
Date: Fri, 23 Jul 2010 14:02:17 -0600

> From: Jonas Bonn <jonas@southpole.se>
> 
> There's no need for this function to be architecture specific and all four
> architectures defining it had the same definition.  The function has been
> moved to drivers/of/platform.c.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> [grant.likely@secretlab.ca: moved to drivers/of/platform.c, simplified code, and added kerneldoc comment]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
