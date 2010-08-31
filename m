Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id BB94CB7113
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 25/35] KVM: PPC: fix compilation of "dump tlbs" debug function
Date: Tue, 31 Aug 2010 04:32:06 +0200
Message-Id: <1283221937-21006-26-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hollis Blanchard <hollis_blanchard@mentor.com>

Missing local variable.

Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/44x_tlb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/44x_tlb.c b/arch/powerpc/kvm/44x_tlb.c
index 9f71b8d..5f3cff8 100644
--- a/arch/powerpc/kvm/44x_tlb.c
+++ b/arch/powerpc/kvm/44x_tlb.c
@@ -47,6 +47,7 @@
 #ifdef DEBUG
 void kvmppc_dump_tlbs(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
 	struct kvmppc_44x_tlbe *tlbe;
 	int i;
 
-- 
1.6.0.2
