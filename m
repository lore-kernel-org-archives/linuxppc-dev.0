From: Borislav Deianov <borislav@lix.polytechnique.fr>
Date: Fri, 7 Jan 2000 02:03:36 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: [2.3.35] syscall 190 on ppc (fwd)
Message-ID: <20000107020336.B569@wispa.polytechnique.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii

Hi,

I posted the message below to linux-kernel but was advised to repost
it here as well.

Best wishes,
Borislav

----- Forwarded message from borislav -----

Date: Wed, 29 Dec 1999 22:57:01 +0200
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: [2.3.35] syscall 190 on ppc

Hi,

According to include/asm-ppc/unistd.h, ugetrlimit on ppc is number 191
but in arch/ppc/kernel/misc.S sys_getrlimit is number 190. Looks like
190 was omitted in unistd.h. Patch against 2.3.35 attached.

Regards,
Borislav

----- End forwarded message -----

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc-190.patch"

--- linux-2.3.35/include/asm-ppc/unistd.h~	Wed Dec 29 14:53:42 1999
+++ linux-2.3.35/include/asm-ppc/unistd.h	Wed Dec 29 21:31:35 1999
@@ -194,13 +194,13 @@
 #define __NR_getpmsg		187	/* some people actually want streams */
 #define __NR_putpmsg		188	/* some people actually want streams */
 #define __NR_vfork		189
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
+#define __NR_ugetrlimit		190	/* SuS compliant getrlimit */
+#define __NR_mmap2		191
+#define __NR_truncate64		192
+#define __NR_ftruncate64	193
+#define __NR_stat64		194
+#define __NR_lstat64		195
+#define __NR_fstat64		196
 
 #define __NR(n)	#n
 

--OXfL5xGRrasGEqWY--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
