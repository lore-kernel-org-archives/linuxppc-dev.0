Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C21F7B7CE4
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 23:07:37 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] Update support for MPC512x
Date: Wed, 27 Jan 2010 13:07:24 +0100
Message-Id: <1264594052-20317-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, linux-usb@vger.kernel.org,
	linux-mtd@lists.infradead.org, rtc-linux@googlegroups.com,
	Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series brings support for the Freescale MPC512x
processsors up to date:

powerpc/mpc5121: Add machine restart support
rtc: Add MPC5121 Real time clock driver
mtd: Add NAND Flash Controller driver
dma: Add MPC512x DMA driver
powerpc/mpc5121: add USB host support
powerpc/mpc5121: shared DIU framebuffer support
powerpc/mpc5121: update mpc5121ads DTS
powerpc/mpc5121: Add default config for MPC5121ADS

The patches are based on v2.6.33-rc5 and cover the following
items:

- platform, DTS
- DMA
- DIU
- UART (without h/w flow control)
- I2C
- NAND
- RTC

The code has been tested on the Freescale/STX "MPC5121ADS" board
(board rev. 4) with a MPC5121e Rev. 2. No attempt was made to provide
backward compatibility to older silicon revisions or older revisions
of the board.

Changes since v1:
 - MPC5121 FEC support patches are removed from this patch series
   as these were not accepted
 - I2C support path is also removed, the I2C support is addressed
   by another patch series from Wolfgang Grandegger:
       i2c-mpc: add support for the Freescale MPC512x and other fixes
   Appropriate fixes for MPC5121ADS DTS are addressed by DTS patch in
   this patch series
 - Detailed changelog is added to each patch of the series

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <rtc-linux@googlegroups.com>
Cc: <linux-mtd@lists.infradead.org>
Cc: <linux-usb@vger.kernel.org>
---
