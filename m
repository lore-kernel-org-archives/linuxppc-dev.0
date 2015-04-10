Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 164681A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:54 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 10 Apr 2015 14:17:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 88E432BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A4He6R48562398
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A4HEnD010325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:17:15 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 4/4] powerpc/tm: Correct minor documentation typos
Date: Fri, 10 Apr 2015 14:16:50 +1000
Message-Id: <c29e4b255aa412c4de98b5cb03432f1f6edfcdb2.1428639350.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428639350.git.sam.bobroff@au1.ibm.com>
References: <cover.1428639350.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428639350.git.sam.bobroff@au1.ibm.com>
References: <cover.1428639350.git.sam.bobroff@au1.ibm.com>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

Discovered some typos while updating the documentation.

 Documentation/powerpc/transactional_memory.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index 98b39af..ba0a2a4 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -175,7 +175,7 @@ These are defined in <asm/reg.h>, and distinguish different reasons why the
 kernel aborted a transaction:
 
  TM_CAUSE_RESCHED       Thread was rescheduled.
- TM_CAUSE_TLBI          Software TLB invalide.
+ TM_CAUSE_TLBI          Software TLB invalid.
  TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
  TM_CAUSE_SYSCALL       Syscall from active transaction.
  TM_CAUSE_SIGNAL        Signal delivered.
@@ -185,7 +185,7 @@ kernel aborted a transaction:
 
 These can be checked by the user program's abort handler as TEXASR[0:7].  If
 bit 7 is set, it indicates that the error is consider persistent.  For example
-a TM_CAUSE_ALIGNMENT will be persistent while a TM_CAUSE_RESCHED will not.q
+a TM_CAUSE_ALIGNMENT will be persistent while a TM_CAUSE_RESCHED will not.
 
 GDB
 ===
-- 
1.7.10.4
