Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id ABA28B6EEC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 12:21:23 +1000 (EST)
Received: from mail110-va3 (localhost.localdomain [127.0.0.1])	by
	mail110-va3-R.bigfish.com (Postfix) with ESMTP id 6EA433200CE	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:19 +0000 (UTC)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.247])	by
	mail110-va3.bigfish.com (Postfix) with ESMTP id 4493F173804C	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:19 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6K2LHmx006726	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 19:21:17 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o6K2XWDZ023963	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 21:33:33 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/6] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Tue, 20 Jul 2010 10:08:19 +0800
Message-ID: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset refactor the file spi_mpc8xxx.c to abstract some common code
as a lib used by the SPI/eSPI controller driver, move the SPI controller
driver code to fsl_spi.c, and add the eSPI controller support with fsl_espi.c.

Tested on P4080DS and MPC8536DS board based on latest Linux tree.

[PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH 2/6] eSPI: add eSPI controller support
[PATCH 3/6] of/spi: add support to parse the SPI flash's partitions
[PATCH 4/6] mtd: m25p80: change the read function to read page by page
[PATCH 5/6] powerpc/of: add eSPI controller dts bindings
[PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds and mpc8536ds board

Thanks,
Mingkai
