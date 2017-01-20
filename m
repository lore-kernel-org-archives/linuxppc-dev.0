Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4pqh0jQMzDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:18:39 +1100 (AEDT)
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/11] PowerPC-KVM: Fine-tuning for some function
 implementations
Message-ID: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:18:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:07:21 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (11):
  Move assignments for the variable "err" in kvm_htab_write()
  Improve a size determination in kvmppc_alloc_hpt()
  Move error code assignments in two functions
  Use common error handling code in kvmppc_clr_passthru_irq()
  Adjust nine checks for null pointers
  Use kcalloc() in kvmppc_alloc_host_rm_ops()
  Improve size determinations in five functions
  Use seq_puts() in xics_debug_show()
  Improve a size determination in two functions
  Use kcalloc() in e500_mmu_host_init()
  Return directly after a failed copy_from_user() in two functions

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 26 +++++++------
 arch/powerpc/kvm/book3s_hv.c        | 73 +++++++++++++++++++------------------
 arch/powerpc/kvm/book3s_xics.c      |  7 ++--
 arch/powerpc/kvm/e500_mmu_host.c    |  5 +--
 arch/powerpc/kvm/powerpc.c          | 48 ++++++++++--------------
 5 files changed, 75 insertions(+), 84 deletions(-)

-- 
2.11.0
