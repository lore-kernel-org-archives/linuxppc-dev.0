From: Miles Lane <miles.lane@comcast.net>
To: paulus@samba.org
Subject: PATCH -- Re: 2.6.0-test3-bk1 -- include/asm/smp.h:61: error: `NR_CPUS' undeclared (first use in this function)
Date: Sun, 10 Aug 2003 12:34:45 -0700
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308101142.16491.miles.lane@comcast.net> <20030810190954.GA13537@lst.de>
In-Reply-To: <20030810190954.GA13537@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308101234.45992.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For Linus:

--- include/asm-ppc/smp.h~      2003-07-27 09:57:50.000000000 -0700
+++ include/asm-ppc/smp.h       2003-08-10 12:30:14.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/threads.h>

 #ifdef CONFIG_SMP


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
