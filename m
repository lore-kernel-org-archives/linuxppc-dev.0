Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 344/493] powerpc: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:53 -0500
Message-Id: <1353349642-3677-344-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Kumar Gala <galak@kernel.crashing.org> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Rob Herring <rob.herring@calxeda.com> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: devicetree-discuss@lists.ozlabs.org 
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 2 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 712a436..e4be690 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -216,7 +216,7 @@ static const struct i2c_device_id mcu_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcu_ids);
 
-static struct of_device_id mcu_of_match_table[] __devinitdata = {
+static struct of_device_id mcu_of_match_table[] = {
 	{ .compatible = "fsl,mcu-mpc8349emitx", },
 	{ },
 };
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index 4c15b19..d913063 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -30,7 +30,7 @@
 #define DRIVER_NAME "bestcomm-core"
 
 /* MPC5200 device tree match tables */
-static struct of_device_id mpc52xx_sram_ids[] __devinitdata = {
+static struct of_device_id mpc52xx_sram_ids[] = {
 	{ .compatible = "fsl,mpc5200-sram", },
 	{ .compatible = "mpc5200-sram", },
 	{}
-- 
1.8.0
