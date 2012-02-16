Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
 Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH v5 14/27] mfd: twl-core.c: Fix the number of interrupts
 managed by twl4030
Date: Thu, 16 Feb 2012 02:09:15 -0700
Message-Id: <1329383368-12122-15-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benoit Cousson <b-cousson@ti.com>

TWL4030 does handle 3 different interrupts ranges: 8 for the core, 8 for
the power events and 18 for the GPIOs.

Change the total number of interrupts managed by TWL4030 from 8 to 34.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mfd/twl-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 8ce3959..4967733 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -149,7 +149,7 @@
 
 #define TWL_MODULE_LAST TWL4030_MODULE_LAST
 
-#define TWL4030_NR_IRQS    8
+#define TWL4030_NR_IRQS    34 /* core:8, power:8, gpio: 18 */
 #define TWL6030_NR_IRQS    20
 
 /* Base Address defns for twl4030_map[] */
-- 
1.7.9
