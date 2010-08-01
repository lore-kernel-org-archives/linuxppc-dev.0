Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C50CAB6F0E
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 18:04:45 +1000 (EST)
Date: Sun, 01 Aug 2010 01:05:01 -0700 (PDT)
Message-Id: <20100801.010501.27813939.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100801074831.1099.3318.stgit@angua>
References: <20100801074831.1099.3318.stgit@angua>
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


Subject should say "struct platform_device" not "struct of_platform",
I think :-)
