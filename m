Message-ID: <3E442EF7.30902@mvista.com>
Date: Fri, 07 Feb 2003 15:11:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: atomic.h patch 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Would someone please apply the following patch to atomic.h?

Thanks,

Mark
--

===== atomic.h 1.22 vs edited =====
--- 1.22/include/asm-ppc/atomic.h       Tue Jan  8 03:01:36 2002
+++ edited/atomic.h     Fri Feb  7 15:05:27 2003
@@ -18,6 +18,7 @@
 #define atomic_set(v,i)                (((v)->counter) = (i))

 extern void atomic_clear_mask(unsigned long mask, unsigned long *addr);
+extern void atomic_set_mask(unsigned long mask, unsigned long *addr);

 #ifdef CONFIG_SMP
 #define SMP_ISYNC      "\n\tisync"


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
