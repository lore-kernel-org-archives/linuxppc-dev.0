Return-Path: <geoff@infradead.org>
Message-ID: <1442266595.3837.2.camel@infradead.org>
Subject: [PATCH V2 3/3] powerpc/ps3: Refresh ps3_defconfig
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 14:36:35 -0700
In-Reply-To: <f9c28dfbef66b7f23f1e542397bd6a77d1258ddd.1442259101.git.geoff@infradead.org>
References: <cover.1442259101.git.geoff@infradead.org>
 <f9c28dfbef66b7f23f1e542397bd6a77d1258ddd.1442259101.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refresh and remove obsolete CONFIG_EXT3_FS.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
V2: Remove ext3 as suggested by Geert.


 arch/powerpc/configs/ps3_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig
b/arch/powerpc/configs/ps3_defconfig
index adc14e8..683b4c3 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -53,7 +53,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
-CONFIG_IPV6=y
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
@@ -141,8 +140,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PS3=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=m
-CONFIG_EXT3_FS=m
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
@@ -175,9 +172,7 @@ CONFIG_DEBUG_LOCKDEP=y
 CONFIG_DEBUG_LIST=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
2.1.0
