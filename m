Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81F6D1A0588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:27 +1100 (AEDT)
Received: by mail-pd0-f180.google.com with SMTP id fp1so2720948pdb.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:25 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 11/11] powerpc: kvm: Kconfig add an option for enabling
 secondary hwthread
Date: Thu, 16 Oct 2014 15:30:00 -0400
Message-Id: <1413487800-7162-12-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 602eb51..de38566 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -93,6 +93,10 @@ config KVM_BOOK3S_64_HV
 
 	  If unsure, say N.
 
+config KVMPPC_ENABLE_SECONDARY
+	tristate "KVM support for running on secondary hwthread in host"
+	depends on KVM_BOOK3S_64_HV
+
 config KVM_BOOK3S_64_PR
 	tristate "KVM support without using hypervisor mode in host"
 	depends on KVM_BOOK3S_64
-- 
1.8.3.1
