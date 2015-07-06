Return-Path: <standby24x7@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6051B1A0D95
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 00:42:06 +1000 (AEST)
Received: by pddu5 with SMTP id u5so19726022pdd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2015 07:42:04 -0700 (PDT)
From: Masanari Iida <standby24x7@gmail.com>
To: benh@kernel.crashing.org, mikey@neuling.org, imunsie@au1.ibm.com,
 corbet@lwn.net, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Doc: powerpc: Fix typos in Documentation/powerpc
Date: Mon,  6 Jul 2015 23:41:57 +0900
Message-Id: <1436193717-29870-1-git-send-email-standby24x7@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fix some spelling typo found in Documentation/powerpc.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/powerpc/cxl.txt         | 2 +-
 Documentation/powerpc/dscr.txt        | 6 +++---
 Documentation/powerpc/qe_firmware.txt | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/powerpc/cxl.txt b/Documentation/powerpc/cxl.txt
index 2a230d01..205c1b8 100644
--- a/Documentation/powerpc/cxl.txt
+++ b/Documentation/powerpc/cxl.txt
@@ -133,7 +133,7 @@ User API
     The following file operations are supported on both slave and
     master devices.
 
-    A userspace library libcxl is avaliable here:
+    A userspace library libcxl is available here:
 	https://github.com/ibm-capi/libcxl
     This provides a C interface to this kernel API.
 
diff --git a/Documentation/powerpc/dscr.txt b/Documentation/powerpc/dscr.txt
index 1ff4400..ece300c 100644
--- a/Documentation/powerpc/dscr.txt
+++ b/Documentation/powerpc/dscr.txt
@@ -4,7 +4,7 @@
 DSCR register in powerpc allows user to have some control of prefetch of data
 stream in the processor. Please refer to the ISA documents or related manual
 for more detailed information regarding how to use this DSCR to attain this
-control of the pefetches . This document here provides an overview of kernel
+control of the prefetches . This document here provides an overview of kernel
 support for DSCR, related kernel objects, it's functionalities and exported
 user interface.
 
@@ -44,7 +44,7 @@ user interface.
 	value into every CPU's DSCR register right away and updates the current
 	thread's DSCR value as well.
 
-	Changing the CPU specif DSCR default value in the sysfs does exactly
+	Changing the CPU specific DSCR default value in the sysfs does exactly
 	the same thing as above but unlike the global one above, it just changes
 	stuff for that particular CPU instead for all the CPUs on the system.
 
@@ -62,7 +62,7 @@ user interface.
 
 	Accessing DSCR through user level SPR (0x03) from user space will first
 	create a facility unavailable exception. Inside this exception handler
-	all mfspr isntruction based read attempts will get emulated and returned
+	all mfspr instruction based read attempts will get emulated and returned
 	where as the first mtspr instruction based write attempts will enable
 	the DSCR facility for the next time around (both for read and write) by
 	setting DSCR facility in the FSCR register.
diff --git a/Documentation/powerpc/qe_firmware.txt b/Documentation/powerpc/qe_firmware.txt
index 2031ddb..e7ac24a 100644
--- a/Documentation/powerpc/qe_firmware.txt
+++ b/Documentation/powerpc/qe_firmware.txt
@@ -117,7 +117,7 @@ specific been defined.  This table describes the structure.
 Extended Modes
 
 This is a double word bit array (64 bits) that defines special functionality
-which has an impact on the softwarew drivers.  Each bit has its own impact
+which has an impact on the software drivers.  Each bit has its own impact
 and has special instructions for the s/w associated with it.  This structure is
 described in this table:
 
-- 
2.5.0.rc1
