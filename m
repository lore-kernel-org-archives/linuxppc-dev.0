From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 12:04:22 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Trivial patch to add PVR_7455
Message-ID: <20030304190421.GA4490@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bringing up a board with a pair of 7455s.
Need this patch.

Thanks,
-Dale

===== include/asm-ppc/processor.h 1.80 vs edited =====
--- 1.80/include/asm-ppc/processor.h	Thu Feb 27 13:22:28 2003
+++ edited/include/asm-ppc/processor.h	Tue Mar  4 11:02:35 2003
@@ -687,6 +687,7 @@
 #define	PVR_7400	0x000C0000
 #define	PVR_7410	0x800C0000
 #define	PVR_7450	0x80000000
+#define	PVR_7455	0x80010000
 /*
  * For the 8xx processors, all of them report the same PVR family for
  * the PowerPC core. The various versions of these processors must be

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
