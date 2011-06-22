Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7AAB7B6FA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 17:55:18 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id D09371C01A2A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:14 +0200 (CEST)
Received: from mail.denx.de (host-82-135-33-74.customer.m-online.net
	[82.135.33.74])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA id CB3BF1C00054
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:14 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail.denx.de (Postfix) with ESMTP id B1D39340066
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:14 +0200 (CEST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc, mpc5200: add support for a4m072 board
Date: Wed, 22 Jun 2011 09:55:07 +0200
Message-Id: <1308729311-15375-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add PHY support (AMD am79c874)
- Add DTS to support a4m072 board
- Update mpc5200_defconfig
- Add config options needed for a4m072 board support
  to mpc5200_defconfig 

cc: Wolfgang Denk <wd@denx.de>

Heiko Schocher (4):
  net, phy: am79c874 support
  powerpc, mpc5200: add a4m072 board support
  powerpc, mpc5200: update mpc5200_defconfig
  powerpc, mpc5200: add options to mpc5200_defconfig

 arch/powerpc/boot/dts/a4m072.dts             |  273 ++++++++++++++++++++++++++
 arch/powerpc/configs/mpc5200_defconfig       |   15 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 drivers/net/phy/Kconfig                      |    5 +
 drivers/net/phy/Makefile                     |    1 +
 drivers/net/phy/amd79.c                      |  109 ++++++++++
 6 files changed, 395 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/a4m072.dts
 create mode 100644 drivers/net/phy/amd79.c

-- 
1.7.5.4
