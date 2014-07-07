Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D8871A0009
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 20:14:56 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20of=3A=20Add=20vendor=20prefix=20for=20EON=20Corporation?=
Date: Mon, 7 Jul 2014 17:29:19 +0800
Message-ID: <1404725359-6754-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1a6793b..3c10a21 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -42,6 +42,7 @@ ebv	EBV Elektronik
 edt	Emerging Display Technologies
 emmicro	EM Microelectronic
 epfl	Ecole Polytechnique Fédérale de Lausanne
+eon	Eon Silicon Solution, Inc.
 epson	Seiko Epson Corp.
 est	ESTeem Wireless Modems
 eukrea  Eukréa Electromatique
-- 
1.8.0
