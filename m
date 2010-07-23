Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C2C1E1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:50:42 +1000 (EST)
Date: Thu, 22 Jul 2010 22:50:58 -0700 (PDT)
Message-Id: <20100722.225058.178805105.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 1/4] of/device: Replace of_device with platform_device
	in includes and core code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100722223006.21557.84275.stgit@angua>
References: <20100722222600.21557.34167.stgit@angua>
	<20100722223006.21557.84275.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
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
Date: Thu, 22 Jul 2010 16:30:06 -0600

> of_device is currently just an #define alias to platform_device until it
> gets removed entirely.  This patch removes references to it from the
> include directories and the core drivers/of code.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
