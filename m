Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E8B0B7140
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 12/35] KVM: PPC: Remove unused define
Date: Tue, 31 Aug 2010 04:31:53 +0200
Message-Id: <1283221937-21006-13-git-send-email-agraf@suse.de>
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

The define VSID_ALL is unused. Let's remove it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index e7c4d00..4040c8d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -30,7 +30,6 @@
 #include "trace.h"
 
 #define PTE_SIZE 12
-#define VSID_ALL 0
 
 void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
-- 
1.6.0.2
