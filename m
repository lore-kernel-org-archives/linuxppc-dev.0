Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMhB05SMQzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:10:32 +1000 (AEST)
Subject: [PATCH 0/6] KVM: PPC: e500: Fine-tuning for two function
 implementations
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:09:57 +0200
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:01:02 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  Use kmalloc_array() in kvm_vcpu_ioctl_config_tlb()
  Less function calls in kvm_vcpu_ioctl_config_tlb() after error detection
  Delete an unnecessary initialisation in kvm_vcpu_ioctl_config_tlb()
  Replace kzalloc() calls by kcalloc() in two functions
  Use kmalloc_array() in kvmppc_e500_tlb_init()
  Rename jump labels in kvmppc_e500_tlb_init()

 arch/powerpc/kvm/e500_mmu.c | 71 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

-- 
2.9.3
