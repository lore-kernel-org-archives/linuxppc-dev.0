Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0A7F4DE9BC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:21:09 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/04] Add support for ARIA board
Date: Wed,  6 May 2009 22:20:57 +0200
Message-Id: <1241641262-5202-1-git-send-email-wd@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series adds support for the ARIA board.

ARIA is a MPC5121e based COM Express board by Dave/DENX.


[PATCH 01/04] mpc5121: prepare support for additional boards
[PATCH 02/04] ARIA: add device tree source file
[PATCH 03/04] mpc5121: add support for ARIA board
[PATCH 04/04] ARIA: add default config file

[PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII clock issue ***
	      [This is actually not a patch for inclusion but a call
	      for help.]

The patches are based on v2.6.30-rc4 and cover the following
items:

- platform, DTS
- DMA
- FEC Ethernet
- UART (without h/w flow control)
- NAND

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
Summary statistics:

 arch/powerpc/boot/dts/aria.dts                 |  407 ++++++
 arch/powerpc/configs/512x/aria_defconfig       | 1789 ++++++++++++++++++++++++
 arch/powerpc/configs/512x/mpc5121ads_defconfig | 1190 ++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig            |    9 +
 arch/powerpc/platforms/512x/Makefile           |    1 +
 arch/powerpc/platforms/512x/aria.c             |   70 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |    1 +
 drivers/net/fs_enet/mii-fec.c                  |    6 +-  [by patch 05]
 8 files changed, 3472 insertions(+), 1 deletions(-)
