Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F83DDDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 08:46:22 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Add CS4270 i2c data to fsl_soc.c
Date: Thu, 15 May 2008 17:46:10 -0500
Message-Id: <1210891570-9074-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c_devices[] array in fsl_soc.c lists all the I2C nodes that are supported
on Freescale boards.  Add an entry for the Cirrus Logic CS4270 so that a
new-style CS4270 driver will work.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a38c364..167523e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -433,6 +433,7 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"dallas,ds1340",  "ds1340"},
 	{"stm,m41t00",     "m41t00"},
 	{"dallas,ds1374",  "rtc-ds1374"},
+	{"cirrus,cs4270",  "cs4270"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
-- 
1.5.5
