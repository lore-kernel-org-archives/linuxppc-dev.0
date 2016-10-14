Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8Hd0cLTzDt2f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:54:05 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so6038608pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:54:05 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 5/6] powerpc/kvm: Comment style and print format fixups
Date: Fri, 14 Oct 2016 11:53:23 +1100
Message-Id: <1476406404-32752-6-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix comment block to match kernel comment style.

Fix print format from signed to unsigned.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 3 ++-
 arch/powerpc/kvm/trace_hv.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6503a63..431950d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2536,7 +2536,8 @@ static void shrink_halt_poll_ns(struct kvmppc_vcore *vc)
 		vc->halt_poll_ns /= halt_poll_ns_shrink;
 }
 
-/* Check to see if any of the runnable vcpus on the vcore have pending
+/*
+ * Check to see if any of the runnable vcpus on the vcore have pending
  * exceptions or are no longer ceded
  */
 static int kvmppc_vcore_check_block(struct kvmppc_vcore *vc)
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index fb21990..ebc6dd4 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -449,7 +449,7 @@ TRACE_EVENT(kvmppc_vcore_wakeup,
 		__entry->tgid   = current->tgid;
 	),
 
-	TP_printk("%s time %lld ns, tgid=%d",
+	TP_printk("%s time %llu ns, tgid=%d",
 		__entry->waited ? "wait" : "poll",
 		__entry->ns, __entry->tgid)
 );
-- 
2.5.5
