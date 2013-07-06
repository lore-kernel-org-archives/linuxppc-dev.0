Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 123FF2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2013 01:07:26 +1000 (EST)
Received: by mail-yh0-f43.google.com with SMTP id b12so1258794yha.16
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jul 2013 08:07:24 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] KVM: PPC: reserve a capability number for multitce support
Date: Sun,  7 Jul 2013 01:07:00 +1000
Message-Id: <1373123227-22969-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d88c8ee..970b1f5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -666,6 +666,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQ_MPIC 90
 #define KVM_CAP_PPC_RTAS 91
 #define KVM_CAP_IRQ_XICS 92
+#define KVM_CAP_SPAPR_MULTITCE 93
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.2
