Return-Path: <jchapman@katalix.com>
Received: from ptb-relay03.plus.net (ptb-relay03.plus.net [212.159.14.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29C7167A2F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 08:07:15 +1100 (EST)
Message-ID: <421CEC19.2010703@katalix.com>
Date: Wed, 23 Feb 2005 20:48:25 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------000406090706060008090102"
Subject: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000406090706060008090102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: James Chapman <jchapman@katalix.com>

Trivial patch to add 7447A and 7457 CPU defs.



--------------000406090706060008090102
Content-Type: text/plain;
 name="ppc_cpu_regs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_cpu_regs.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/23 16:17:49+00:00 jchapman@katalix.com 
#   Add ppc PVR definitions for 7447A and 7457 CPUs.
# 
# include/asm-ppc/reg.h
#   2005/02/23 16:17:40+00:00 jchapman@katalix.com +2 -0
#   Add ppc PVR definitions for 7447A and 7457 CPUs.
# 
diff -Nru a/include/asm-ppc/reg.h b/include/asm-ppc/reg.h
--- a/include/asm-ppc/reg.h	2005-02-23 16:18:45 +00:00
+++ b/include/asm-ppc/reg.h	2005-02-23 16:18:45 +00:00
@@ -471,7 +471,9 @@
 #define PVR_750P	PVR_740P
 #define PVR_7400	0x000C0000
 #define PVR_7410	0x800C0000
+#define PVR_7447A	0x80030000
 #define PVR_7450	0x80000000
+#define PVR_7457	0x80020000
 #define PVR_8540	0x80200000
 #define PVR_8560	0x80200000
 /*

--------------000406090706060008090102--
