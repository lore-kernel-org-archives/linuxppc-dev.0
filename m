Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id A93311007D2
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:22:33 +1000 (EST)
Received: from mail25-db3 (localhost.localdomain [127.0.0.1])	by
	mail25-db3-R.bigfish.com (Postfix) with ESMTP id 0C5055B810E	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:21 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.251])	by
	mail25-db3.bigfish.com (Postfix) with ESMTP id C93DBB7804F	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:20 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o72876CK012325	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:07:16 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7287BLu014167	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 03:07:12 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 0/6] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Mon, 2 Aug 2010 15:51:58 +0800
Message-ID: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In-Reply-To: 

This patchset refactor the file spi_mpc8xxx.c to abstract some common
code as a lib used by the SPI/eSPI controller driver, move the SPI 
controller driver code to spi_fsl_spi.c, and add the eSPI controller
support with spi_fsl_espi.c.

Tested on P4080DS and MPC8536DS board based on latest Linux tree.

[PATCH v2 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH v2 2/6] eSPI: add eSPI controller support
[PATCH v2 3/6] mtd: m25p80: add support to parse the SPI flash's partitions
[PATCH v2 4/6] mtd: m25p80: add a read function to read page by page
[PATCH v2 5/6] powerpc/of: add eSPI controller dts bindings
[PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds and mpc8536ds board

Thanks,
Mingkai
