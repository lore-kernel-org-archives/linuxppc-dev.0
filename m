Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20E9B2C010F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 18:38:18 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz10so5952334pad.16
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 01:38:17 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 03/13] KVM: PPC: reserve a capability number for multitce
 support
Date: Wed, 28 Aug 2013 18:37:40 +1000
Message-Id: <1377679070-3515-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to reserve a capablity number for upcoming support
of H_PUT_TCE_INDIRECT and H_STUFF_TCE pseries hypercalls
which support mulptiple DMA map/unmap operations per one call.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
2013/07/16:
* changed the number
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index acccd08..99c2533 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_RTAS 91
 #define KVM_CAP_IRQ_XICS 92
 #define KVM_CAP_ARM_EL1_32BIT 93
+#define KVM_CAP_SPAPR_MULTITCE 94
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.4.rc4
