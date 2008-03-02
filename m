Return-Path: <monstr@seznam.cz>
Received: from bor.wifiinternet.cz (smtp1.wifiinternet.cz [89.31.47.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86D57DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Mar 2008 05:51:44 +1100 (EST)
Message-ID: <47CAF0FC.70706@seznam.cz>
Date: Sun, 02 Mar 2008 19:25:00 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx PowerPC
References: <47BD212B.6090809@dlasys.net>
	<20080221175025.7817BBD8057@mail91-sin.bigfish.com>
In-Reply-To: <20080221175025.7817BBD8057@mail91-sin.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

> http://git.xilinx.com/gen-mhs-devtree.git contains two utilities for
> generating device trees from EDK projects.  The older option is a python
> script, originally written by Grant.  The newer (and probably more
> mature at this point) option is an EDK BSP generator for u-boot,
> originally written by Michal Simek.  Preferably this gets passed from a
> uboot, although it's also possible to compile it into the kernel.
> Currently, the uboot option is somewhat annoying because there's not a
> good surefire way for getting uboot up and running on an EDK design.
> (Unfortunately, the EDK BSP generator is incomplete, and the uboot
> support for virtex needs some work to get it integrated as well).

U-BOOT part will be removed from EDK generator. The new name will be only
fdt_v1.00.a. I have prepared separated version for FDT generation and for U-BOOT
generation.

Steve: You can remove U-BOOT part from generator. This part is useful only for
Microblaze cpu.

Regards,
Michal Simek
