Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2E8CB6F05
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 07:14:11 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Support for MPC8308RDB development board
Date: Fri,  9 Jul 2010 00:10:37 +0400
Message-Id: <1278619839-23998-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches add support for MPC8308RDB development board from Freescale.
Supported hardware:
 DUART
 Dual Ethernet
 NOR and NAND flashes
 I2C
 USB device
 PCIE (MSI support is broken by commit 3da34aa)

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
