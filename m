Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82BACDDEBD
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 01:25:11 +1100 (EST)
Message-Id: <0802475D-30B4-4954-96D9-39522FACCDBD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: how to handle TARGET_CPM in cuboot-85xx?
Date: Thu, 24 Jan 2008 08:24:42 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott,

I have to make this change for some board to cuboot-85xx.c:

diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/ 
cuboot-85xx.c
index 6776a1a..e2616f2 100644
--- a/arch/powerpc/boot/cuboot-85xx.c
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -15,6 +15,7 @@
  #include "cuboot.h"

  #define TARGET_85xx
+#define TARGET_CPM2
  #include "ppcboot.h"

  static bd_t bd;


--

however it varies which boards need this.  Should I just duplicate  
cuboot-85xx.c into cuboot-<boardname>.c as the way to handle this  
right now?

- k
