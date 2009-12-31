Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1523BB6EF2
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 08:27:33 +1100 (EST)
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com
	([174.113.191.234] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1NQRuc-0005AP-FH
	for linuxppc-dev@ozlabs.org; Thu, 31 Dec 2009 15:46:26 -0500
Date: Thu, 31 Dec 2009 15:45:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Simplify param.h by including <asm-generic/param.h>
Message-ID: <alpine.LFD.2.00.0912311544570.7175@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/powerpc/include/asm/param.h b/arch/powerpc/include/asm/param.h
index 094f63d..965d454 100644
--- a/arch/powerpc/include/asm/param.h
+++ b/arch/powerpc/include/asm/param.h
@@ -1,22 +1 @@
-#ifndef _ASM_POWERPC_PARAM_H
-#define _ASM_POWERPC_PARAM_H
-
-#ifdef __KERNEL__
-#define HZ		CONFIG_HZ	/* internal kernel timer frequency */
-#define USER_HZ		100		/* for user interfaces in "ticks" */
-#define CLOCKS_PER_SEC	(USER_HZ)	/* frequency at which times() counts */
-#endif /* __KERNEL__ */
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif	/* _ASM_POWERPC_PARAM_H */
+#include <asm-generic/param.h>


rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
