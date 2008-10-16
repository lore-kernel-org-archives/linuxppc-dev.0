Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: remove empty #else from signal_64.c
Date: Thu, 16 Oct 2008 15:21:07 +1100
Message-ID: <18704.1224130867@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove empty/bogus #else from signal_64.c

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/signal_64.c |    2 --
 1 file changed, 2 deletions(-)

Benh: Trivial cleanup patch for 2.6.28...

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 65ad925..c6a8f23 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -235,8 +235,6 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	else
 		for (i = 0; i < 32 ; i++)
 			current->thread.fpr[i][TS_VSRLOWOFFSET] = 0;
-
-#else
 #endif
 	return err;
 }
