Return-Path: <prvs=0189afdd1f=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 81B0D140112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:30:42 +1000 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/3] devicetree: bindings: add Zarlink to the vendor
 prefixes
Date: Tue, 22 Apr 2014 11:30:29 +0200
Message-Id: <1398159031-10110-2-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1398159031-10110-1-git-send-email-valentin.longchamp@keymile.com>
References: <1398159031-10110-1-git-send-email-valentin.longchamp@keymile.com>
Cc: devicetree@vger.kernel.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even though the company belongs to Microsemi, many chips are still
labeled as Zarlink. Among them is the family of network clock generators,
the zl3034x.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- add a patch so that the Zarlink vendor prefix is defined

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0f01c9b..93cc7dc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -119,3 +119,4 @@ wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
 xes	Extreme Engineering Solutions (X-ES)
 xlnx	Xilinx
+zarlink	Zarlink Semiconductor
-- 
1.8.0.1
