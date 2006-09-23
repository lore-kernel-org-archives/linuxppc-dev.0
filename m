Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A087367B83
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 01:46:00 +1000 (EST)
Date: Sat, 23 Sep 2006 16:45:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] #elif that should've been #elif defined
Message-ID: <20060923154555.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 #elif CONFIG_44x
in ibm4xx.h should've been
 #elif defined(CONFIG_44x)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-ppc/ibm4xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index cf62b69..499c146 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -86,7 +86,7 @@ #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET	0
 #endif
 
-#elif CONFIG_44x
+#elif defined(CONFIG_44x)
 
 #if defined(CONFIG_BAMBOO)
 #include <platforms/4xx/bamboo.h>
-- 
1.4.2.GIT
