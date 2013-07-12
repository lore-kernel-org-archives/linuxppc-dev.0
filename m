Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC 4/8] dts: mpc512x: prepare for preprocessor support
Date: Fri, 12 Jul 2013 17:26:17 +0200
Message-Id: <1373642781-32631-5-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prepare C preprocessor support when processing MPC512x DTS files
- switch from DTS syntax to CPP syntax for include specs
- create a symlink such that DTS processing can reference includes

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts          |    2 +-
 arch/powerpc/boot/dts/include/dt-bindings |    1 +
 arch/powerpc/boot/dts/mpc5121ads.dts      |    2 +-
 arch/powerpc/boot/dts/pdm360ng.dts        |    2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 120000 arch/powerpc/boot/dts/include/dt-bindings

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a27a460..a543c40 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -10,7 +10,7 @@
  */
 
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "ac14xx";
diff --git a/arch/powerpc/boot/dts/include/dt-bindings b/arch/powerpc/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/powerpc/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 7d3cb79..c228a0a 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "mpc5121ads";
diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 7433740..871c16d 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -13,7 +13,7 @@
  * option) any later version.
  */
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "pdm360ng";
-- 
1.7.10.4
