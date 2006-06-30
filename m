Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id ED24267A79
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 09:55:47 +1000 (EST)
Date: Fri, 30 Jun 2006 18:55:42 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Documentation: correct values in MPC5848E SEC example node
Message-Id: <20060630185542.102af583.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(this patch had apparently slipped through the cracks)

Documentation: correct values in MPC5848E SEC example node

---
commit 27ef8f30208ceb62c5387e834a335558e7e88c70
tree e96c74f732489115651ea00d0514e66e8050c60a
parent 1f4a90670bacbf61f2fcc19a9e0e78748c932a25
author Kim Phillips <kim.phillips@freescale.com> Tue, 02 May 2006 11:38:23 -0500
committer Kim Phillips <kim.phillips@freescale.com> Tue, 02 May 2006 11:38:23 -0500

 Documentation/powerpc/booting-without-of.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
 
 
