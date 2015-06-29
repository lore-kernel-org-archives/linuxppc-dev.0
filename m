Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0023.hostedemail.com
 [216.40.44.23])
 by lists.ozlabs.org (Postfix) with ESMTP id D5CA41A0037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 07:40:10 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id A7517184767
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 21:30:46 +0000 (UTC)
Message-ID: <1435613439.9587.56.camel@perches.com>
Subject: [PATCH] powerpc: Remove redundant breaks
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Jun 2015 14:30:39 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

break; break; isn't useful.

Remove one.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/kvm.c | 1 -
 arch/powerpc/xmon/xmon.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 33aa4dd..9ad37f8 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -649,7 +649,6 @@ static void kvm_check_ins(u32 *inst, u32 features)
 			kvm_patch_ins_mtsrin(inst, inst_rt, inst_rb);
 		}
 		break;
-		break;
 #endif
 	}
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e599259..7a39f6c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1987,7 +1987,6 @@ memex(void)
 			case '^':
 				adrs -= size;
 				break;
-				break;
 			case '/':
 				if (nslash > 0)
 					adrs -= 1 << nslash;
