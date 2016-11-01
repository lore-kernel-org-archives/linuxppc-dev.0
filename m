Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7JTj0WxlzDsrd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 15:41:29 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a136so7154742pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 21:41:28 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, agraf@suse.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH V3 0/2] powerpc: add support for ISA v2.07 compat level
Date: Tue,  1 Nov 2016 15:41:01 +1100
Message-Id: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Version v3.00 of the ISA added a new compat level to the processor
compatibility register (PCR), an ISA v2.07 compatibility mode.

Upstream QEMU already supports this so it may as well go into the kernel
now.

Change Log:

V1 -> V2: 
- Reworked logic to set and mask the PCR, no functional change

V2 -> V3:
- Reworked logic again, no functional change

Suraj Jitindar Singh (2):
  powerpc: Define new ISA v3.00 logical PVR value and PCR register value
  powerpc/kvm: Update kvmppc_set_arch_compat() for ISA v3.00

 arch/powerpc/include/asm/reg.h |  3 +++
 arch/powerpc/kvm/book3s_hv.c   | 38 +++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.5.5
