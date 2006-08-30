Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id EE7DB67B7C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 04:30:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PCIe enhanced configuration mechanism support on ppc arch
Date: Wed, 30 Aug 2006 20:30:12 +0200
References: <7cc604637892c0a00a5e3e38192494d7@bga.com>
In-Reply-To: <7cc604637892c0a00a5e3e38192494d7@bga.com>
MIME-Version: 1.0
Message-Id: <200608302030.13600.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 August 2006 18:30, Milton Miller wrote:
> The config access support is in arch/powerpc/kernel/rtas_pci.c,
> the setting of pci_ext_config_space is at arch/powerpc/kernel/pci_dn.c.
> 
Well, so far that is only true for pseries and cell, as the others
normally don't use rtas for config space access.

Other platforms have their config space implementation in
arch/powerpc/platforms/<platform>/pci.c and may not support
this.

	Arnd <><
