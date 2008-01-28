Return-Path: <jonsmirl@gmail.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id F1518DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:43:18 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JVC007T6ZLKO452@vms040.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 28 Jan 2008 08:44:09 -0600 (CST)
Date: Mon, 28 Jan 2008 09:42:04 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for breaking
	out common code.
In-reply-to: <20080128144202.8410.14647.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20080128144204.8410.98868.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080128144202.8410.14647.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 drivers/i2c/busses/Makefile      |    2 
 drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------------
 3 files changed, 423 insertions(+), 421 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
 delete mode 100644 drivers/i2c/busses/i2c-mpc.c


diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index ea7068f..171800d 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the i2c bus drivers.
 #
 
+i2c-mpc-objs	:= i2c-mpc-drv.o
+
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc-drv.c
similarity index 100%
rename from drivers/i2c/busses/i2c-mpc.c
rename to drivers/i2c/busses/i2c-mpc-drv.c
