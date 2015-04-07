Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAC371A0BA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:56:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 7 Apr 2015 10:56:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 95F43357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:56:11 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t370u3oD30081036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:56:11 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t370tbFL026812
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:55:38 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v3 4/4] powerpc/tm: Correct minor documentation typos
Date: Tue,  7 Apr 2015 10:54:50 +1000
Message-Id: <9095bd465b988a5c3a96bb0b58713eddcd2b099c.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
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
