Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsjVl4qrSzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:41:03 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w12so26261889pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:41:03 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: afaerber@suse.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Documentation: remove overlay-notes reference to non-existent
 file
Date: Tue, 20 Jun 2017 15:40:53 -0700
Message-Id: <1497998453-1585-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frank Rowand <frank.rowand@sony.com>

File dt-object-internal.txt does not exist.  Remove a reference to it
and fix up tags for references to other files.

Reported-by: afaerber@suse.de
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/devicetree/overlay-notes.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index d418a6ce9812..eb7f2685fda1 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -3,8 +3,7 @@ Device Tree Overlay Notes
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
-companion document to Documentation/devicetree/dt-object-internal.txt[1] &
-Documentation/devicetree/dynamic-resolution-notes.txt[2]
+companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
 
 How overlays work
 -----------------
@@ -16,8 +15,7 @@ Since the kernel mainly deals with devices, any new device node that result
 in an active device should have it created while if the device node is either
 disabled or removed all together, the affected device should be deregistered.
 
-Lets take an example where we have a foo board with the following base tree
-which is taken from [1].
+Lets take an example where we have a foo board with the following base tree:
 
 ---- foo.dts -----------------------------------------------------------------
 	/* FOO platform */
@@ -36,7 +34,7 @@ which is taken from [1].
 	};
 ---- foo.dts -----------------------------------------------------------------
 
-The overlay bar.dts, when loaded (and resolved as described in [2]) should
+The overlay bar.dts, when loaded (and resolved as described in [1]) should
 
 ---- bar.dts -----------------------------------------------------------------
 /plugin/;	/* allow undefined label references and record them */
-- 
Frank Rowand <frank.rowand@sony.com>
