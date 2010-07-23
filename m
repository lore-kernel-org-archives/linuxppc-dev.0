Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3F7BE100808
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:50:59 +1000 (EST)
Date: Thu, 22 Jul 2010 22:51:15 -0700 (PDT)
Message-Id: <20100722.225115.160202643.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 3/4] sparc: remove references to of_device and to_of_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100722223016.21557.40832.stgit@angua>
References: <20100722222600.21557.34167.stgit@angua>
	<20100722223016.21557.40832.stgit@angua>
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
Date: Thu, 22 Jul 2010 16:30:16 -0600

> of_device is just a #define alias to platform_device.  This patch
> replaces all references to it with platform_device.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
