Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A25B71A0A74
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 05:09:11 +1100 (AEDT)
Received: by mail-wi0-f180.google.com with SMTP id n3so2909698wiv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 10:09:08 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Alexander Graf <agraf@suse.de>,
	Gleb Natapov <gleb@kernel.org>
Subject: [PATCH] arch: powerpc: kvm: book3s_pr.c:  Remove unused function
Date: Sun,  7 Dec 2014 19:11:48 +0100
Message-Id: <1417975908-14327-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: kvm@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function get_fpr_index() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kvm/book3s_pr.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index cf2eb16..f573839 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -644,11 +644,6 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return r;
 }
 
-static inline int get_fpr_index(int i)
-{
-	return i * TS_FPRWIDTH;
-}
-
 /* Give up external provider (FPU, Altivec, VSX) */
 void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 {
-- 
1.7.10.4
