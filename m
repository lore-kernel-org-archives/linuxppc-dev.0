Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6Zwb2RzXzDvW8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 11:28:47 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id s8so7155939pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 17:28:47 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, agraf@suse.com
Subject: [PATCH V2 0/2] powerpc: add support for ISA v2.07 compat level
Date: Mon, 31 Oct 2016 11:28:21 +1100
Message-Id: <1477873703-22403-1-git-send-email-sjitindarsingh@gmail.com>
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

Suraj Jitindar Singh (2):
  powerpc: Define new ISA v3.00 logical PVR value and PCR register value
  powerpc/kvm: Update kvmppc_set_arch_compat() for ISA v3.00

 arch/powerpc/include/asm/reg.h |  2 ++
 arch/powerpc/kvm/book3s_hv.c   | 32 +++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.5.5
