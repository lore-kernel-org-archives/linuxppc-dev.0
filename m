Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjt9K2JtxzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 11:42:29 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id vv3so695086pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2016 18:42:29 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/2] devicetree/bindings: Add binding for operator panel on
 FSP machines
Date: Mon, 11 Apr 2016 11:41:29 +1000
Message-Id: <1460338890-19693-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a binding to Documentation/devicetree/bindings/powerpc/opal
(oppanel-opal.txt) for the operator panel which is present on IBM
pseries machines with FSPs.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 .../devicetree/bindings/powerpc/opal/oppanel-opal.txt      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt

diff --git a/Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt b/Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt
new file mode 100644
index 0000000..dffb791
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt
@@ -0,0 +1,14 @@
+IBM OPAL Operator Panel Binding
+-------------------------------
+
+Required properties:
+- compatible : Should be "ibm,opal-oppanel".
+- #lines     : Number of lines on the operator panel e.g. <0x2>.
+- #length    : Number of characters per line of the operator panel e.g. <0x10>.
+
+Example:
+	oppanel {
+		compatible = "ibm,opal-oppanel";
+		#lines = <0x2>;
+		#length = <0x10>;
+	};
-- 
2.5.0
