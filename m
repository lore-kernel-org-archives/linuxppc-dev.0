Return-Path: <bgill@freescale.com>
Date: Fri, 21 Oct 2005 16:16:58 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0510211615420.20228@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: Fix types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc: Fix types.h

I noticed that Paul had already pulled the version of types.h that
is missing the config.h include into the merge tree - this patch adds 
it back in.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit ffaa354bbf9c75b1101167137662ba37bb6cdb02
tree 4b9df364146754813e7425efab1d6ac322ee2abc
parent b30219b583bf29e7f6a1236f07e5727626979d6c
author Becky Bruce <becky.bruce@freescale.com> Fri, 21 Oct 2005 16:11:26 -0500
committer Becky Bruce <becky.bruce@freescale.com> Fri, 21 Oct 2005 16:11:26 -0500

 include/asm-powerpc/types.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -64,6 +64,8 @@ typedef struct {
 
 #ifndef __ASSEMBLY__
 
+#include <linux/config.h>
+
 typedef signed char s8;
 typedef unsigned char u8;
 
