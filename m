Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 955E41A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 20:13:11 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
Subject: [PATCH] devicetree/bindings: Add binding for micron n25q512a memory
Date: Thu, 3 Jul 2014 15:42:56 +0530
Message-ID: <1404382376-3115-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-Micron n25q512a memory is supported by m25p80 driver.
 Add compatible field required to support n25q512a in m25p80.txt
-Add micron to the vendor-prefixes.txt file

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Documentation/devicetree/bindings/mtd/m25p80.txt   |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt b/Documentation/devicetree/bindings/mtd/m25p80.txt
index 4611aa8..ce02e81 100644
--- a/Documentation/devicetree/bindings/mtd/m25p80.txt
+++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
@@ -7,6 +7,7 @@ Required properties:
                the DT binding is not Linux-only, but in case of Linux, see the
                "spi_nor_ids" table in drivers/mtd/spi-nor/spi-nor.c for the list
                of supported chips.
+               example: "micron,n25q512a"
 - reg : Chip-Select number
 - spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at
 
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4d7f375..a44cfee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -79,6 +79,7 @@ marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
+micron	Micron Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
-- 
1.7.4.1
