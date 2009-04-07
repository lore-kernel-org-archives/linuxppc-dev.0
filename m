Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 3/4 v2] mtd/powerpc: Remove unused "device-width" property
Date: Tue,  7 Apr 2009 10:39:35 +0200
Message-Id: <1239093575-12147-1-git-send-email-sr@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This property is unused. It's not handled as all by the physmap_of
driver. So let's remove it from the documentation.

Signed-off-by: Stefan Roese <sr@denx.de>
CC: Grant Likely <grant.likely@secretlab.ca>
---
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
index cd474f9..ab1115e 100644
--- a/Documentation/powerpc/dts-bindings/mtd-physmap.txt
+++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
@@ -8,8 +8,6 @@ file systems on embedded devices.
  - reg : Address range of the flash chip
  - bank-width : Width (in bytes) of the flash bank.  Equal to the
    device width times the number of interleaved chips.
- - device-width : (optional) Width of a single flash chip.  If
-   omitted, assumed to be equal to 'bank-width'.
  - #address-cells, #size-cells : Must be present if the flash has
    sub-nodes representing partitions (see below).  In this case
    both #address-cells and #size-cells must be equal to 1.
@@ -48,7 +46,6 @@ Example:
 		compatible = "amd,am29lv128ml", "cfi-flash";
 		reg = <ff000000 01000000>;
 		bank-width = <4>;
-		device-width = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		fs@0 {
-- 
1.6.2.2
