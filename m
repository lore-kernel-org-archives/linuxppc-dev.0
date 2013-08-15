Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/6] powerpc: Add more trap names to xmon
Date: Thu, 15 Aug 2013 15:22:16 +1000
Message-Id: <1376544139-26783-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
References: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We haven't updated these for a while it seems, it's nice to have in the
oops output.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 96bf5bd..9f3655b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1256,11 +1256,18 @@ const char *getvecname(unsigned long vec)
 	case 0x700:	ret = "(Program Check)"; break;
 	case 0x800:	ret = "(FPU Unavailable)"; break;
 	case 0x900:	ret = "(Decrementer)"; break;
+	case 0x980:	ret = "(Hypervisor Decrementer)"; break;
+	case 0xa00:	ret = "(Doorbell)"; break;
 	case 0xc00:	ret = "(System Call)"; break;
 	case 0xd00:	ret = "(Single Step)"; break;
+	case 0xe40:	ret = "(Emulation Assist)"; break;
+	case 0xe60:	ret = "(HMI)"; break;
+	case 0xe80:	ret = "(Hypervisor Doorbell)"; break;
 	case 0xf00:	ret = "(Performance Monitor)"; break;
 	case 0xf20:	ret = "(Altivec Unavailable)"; break;
 	case 0x1300:	ret = "(Instruction Breakpoint)"; break;
+	case 0x1500:	ret = "(Denormalisation)"; break;
+	case 0x1700:	ret = "(Altivec Assist)"; break;
 	default: ret = "";
 	}
 	return ret;
-- 
1.8.1.2
