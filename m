Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9347F67B65
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 06:10:21 +1000 (EST)
Date: Mon, 3 Jul 2006 15:10:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Documentation: correct values in MPC8548E SEC example node
Message-Id: <20060703151014.770aaf98.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(fixed 5848 -> 8548)

Documentation: correct values in MPC8548E SEC example node

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---

 Documentation/powerpc/booting-without-of.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

179e7f97a4ccee6d3a39af5fb422ab16e0beded8
diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 217e517..3c62e66 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1436,9 +1436,9 @@ platforms are moved over to use the flat
                interrupts = <1d 3>;
                interrupt-parent = <40000>;
                num-channels = <4>;
-               channel-fifo-len = <24>;
+               channel-fifo-len = <18>;
                exec-units-mask = <000000fe>;
-               descriptor-types-mask = <073f1127>;
+               descriptor-types-mask = <012b0ebf>;
        };
 
 
-- 
1.2.4
