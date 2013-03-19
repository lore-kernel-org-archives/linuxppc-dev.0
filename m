Return-Path: <geoff@infradead.org>
Message-ID: <1363655503.1075.40.camel@smoke>
Subject: [PATCH for 3.9] powerpc/ps3: Update ps3_defconfig
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Mar 2013 18:11:43 -0700
In-Reply-To: <cover.1360810584.git.geoff@infradead.org>
References: <cover.1360810584.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refresh and set CONFIG_RD_LZMA=y.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Ben,

This sets CONFIG_RD_LZMA=y, which is needed to boot with
newer initrd images.

Please apply for 3.9.

Also available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

-Geoff


 arch/powerpc/configs/ps3_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 7a5c15f..f791962 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -3,11 +3,11 @@ CONFIG_TUNE_CELL=y
 CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_LZMA=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 # CONFIG_PERF_EVENTS is not set
-- 
1.7.9.5
