Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6231FDDF9C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 07:56:56 +1000 (EST)
Date: Tue, 10 Apr 2007 16:56:49 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc: Add 'mdio' to bus scan id list for platforms
	with QE UEC
Message-Id: <20070410165649.4784d630.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 'mdio' to bus scan id list for platforms with QE UEC
as a consequence of converting UEC mdio driver to an
of_platform driver in the ucc_geth phylib conversion patch.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
please consider for 2.6.22


 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index fff09f5..94843ed 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -111,6 +111,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .type = "mdio", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 6b71e9f..b0b22bb 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -73,6 +73,7 @@ static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .type = "mdio", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 526ed09..bceeff8 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -118,6 +118,7 @@ static struct of_device_id mpc836x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .type = "mdio", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 81144d2..f721fb6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -147,6 +147,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .type = "mdio", },
 	{},
 };
 
-- 
1.5.0.1
