Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CAD8C100CAA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 15:28:19 +1000 (EST)
Date: Wed, 21 Jul 2010 22:28:35 -0700 (PDT)
Message-Id: <20100721.222835.258899665.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 3/5] of/platform: remove all of_bus_type and
	of_platform_bus_type references
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100721234005.7782.52867.stgit@angua>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721234005.7782.52867.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:05 -0600

> Both of_bus_type and of_platform_bus_type are just #define aliases
> for the platform bus.  This patch removes all references to them and
> switches to the of_register_platform_driver()/of_unregister_platform_driver()
> API for registering.
> 
> Subsequent patches will convert each user of of_register_platform_driver()
> into plain platform_drivers without the of_platform_driver shim.  At which
> point the of_register_platform_driver()/of_unregister_platform_driver()
> functions can be removed.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
