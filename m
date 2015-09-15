Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA61A1A2C76
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:51:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 07CA62BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAos7j62062836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:02 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAoUbR007798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 8/9] KVM: Fix KVM_SMI chapter number
Date: Tue, 15 Sep 2015 20:49:38 +1000
Message-Id: <1442314179-9706-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The KVM_SMI capability is following the KVM_S390_SET_IRQ_STATE capability
which is "4.95", this changes the number of the KVM_SMI chapter to 4.96.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 Documentation/virtual/kvm/api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d9eccee..d86d831 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3009,7 +3009,7 @@ len must be a multiple of sizeof(struct kvm_s390_irq). It must be > 0
 and it must not exceed (max_vcpus + 32) * sizeof(struct kvm_s390_irq),
 which is the maximum number of possibly pending cpu-local interrupts.
 
-4.90 KVM_SMI
+4.96 KVM_SMI
 
 Capability: KVM_CAP_X86_SMM
 Architectures: x86
-- 
2.4.0.rc3.8.gfb3e7d5
