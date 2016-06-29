Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfT1X49gFzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:39:12 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id t190so3375262pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:39:12 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: arnd@arndb.de, robh@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 sjitindarsingh@gmail.com
Subject: [PATCH V5 1/3] devicetree/bindings: Add binding for operator panel on
 FSP machines
Date: Wed, 29 Jun 2016 13:38:37 +1000
Message-Id: <1467171519-19882-1-git-send-email-sjitindarsingh@gmail.com>
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
Power Systems machines with FSPs.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

---

Change Log:

V1 -> V2:
	- Nothing
V2 -> V3:
	- Change "IBM pseries machines" to "IBM Power Systems machines"
	in the commit message for improved clarity.
V3 -> V5:
	- Nothing
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
2.5.5
