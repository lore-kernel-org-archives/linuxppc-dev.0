Message-Id: <200201072223.RAA06381@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Link-time failures from "simple" CFLAGS changes
Date: Mon, 07 Jan 2002 17:23:09 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sheesh!    Well, OK then: please apply this patch:


===== Documentation/Changes 1.12 vs edited =====
--- 1.12/Documentation/Changes  Fri Dec  7 14:01:21 2001
+++ edited/Documentation/Changes        Mon Jan  7 17:20:20 2002
@@ -92,6 +92,8 @@
 greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
 or derivatives, be sure not to use -fstrict-aliasing (which, depending on
 your version of gcc 2.95.x, may necessitate using -fno-strict-aliasing).
+On the other hand, -O0 will cause your build to fail because inline
+functions are only defined when *some* optimization is in effect.

 Make
 ----


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
