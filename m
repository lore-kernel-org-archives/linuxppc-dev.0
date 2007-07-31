Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2E606DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:27:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Wed, 1 Aug 2007 00:25:33 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200708010007.12922.arnd@arndb.de> <46AFB686.40508@mvista.com>
In-Reply-To: <46AFB686.40508@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708010025.33732.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 01 August 2007, Dave Jiang wrote:
> Doh! I sent out the reworked patches right before your comments. Do you happen
> to know where I can find an example of how to do this? In regards to making a
> platform_device a child of the PCI host bridge that is.... Thanks!
> 

When you use an open-coded version of platform_device_register_simple(),
you can set dev->parent before calling platform_device_add.

	Arnd <><
