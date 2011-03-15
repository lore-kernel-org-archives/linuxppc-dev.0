Return-Path: <B08248@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2ACEB7090
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 05:54:33 +1100 (EST)
Received: from mail38-db3 (localhost.localdomain [127.0.0.1])	by
	mail38-db3-R.bigfish.com (Postfix) with ESMTP id 1A74D670372	for
	<linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 18:39:21 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.248])	by
	mail38-db3.bigfish.com (Postfix) with ESMTP id C7DA51B30055	for
	<linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 18:39:20 +0000 (UTC)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] update name of pic-no-reset property
Date: Tue, 15 Mar 2011 12:37:58 -0600
Message-ID: <1300214278-1588-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

-changed name from 'no-reset' to 'pic-not-reset' be consisent with
 Meador Inge's open pic binding patch
-update definition

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/mpic.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/mpic.txt b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
index fdf97c5..8b76e0f 100644
--- a/Documentation/powerpc/dts-bindings/fsl/mpic.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
@@ -44,7 +44,7 @@ PROPERTIES
       Value type: <u32>
       Definition: Shall be 0.
 
-  - no-reset
+  - pic-no-reset
       Usage: optional
       Value type: <empty>
       Definition: The presence of this property specifies that the
@@ -53,7 +53,10 @@ PROPERTIES
           configuration registers to a sane state-- masked or
           directed at other cores.  This ensures that the client
           program will not receive interrupts for sources not belonging
-          to the client.
+          to the client.  The presence of this property also mandates
+          that any initialization related to interrupt sources shall
+          be limited to sources explicitly referenced in the device tree.
+
 
 INTERRUPT SPECIFIER DEFINITION
 
-- 
1.7.2.2
