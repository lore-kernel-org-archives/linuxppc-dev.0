Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E0915DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 19:47:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 09:47:02 +0100
References: <989B956029373F45A0B8AF02970818900D4286@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818900D4286@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702070947.03187.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 February 2007 03:22, Li Yang-r58472 wrote:
> 
> > I'm not sure if scanning through the device tree to find mmio
> > addresses is still considered valid style. I would instead prefer
> > you to provide a of_platform_driver that attaches to the
> > respective 'compatible' property and does the register access
> > in its probe() function in order to not conflict with other drivers.
> 
> The driver will not use of_platform_driver for it to be used through
> multiple architectures.

Huh? I don't understand. You currently use of_find_compatible_node(),
which is also platform-specific.

	Arnd <><
