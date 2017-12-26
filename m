Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5bgY6DMJzDrW6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:00:25 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBQCxHlG058912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 08:00:23 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f3mf2m3g8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 08:00:23 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 26 Dec 2017 06:00:22 -0700
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org
Subject: [PATCH RESEND 0/1] Implements MMIO emulation for lvx/stvx instructions
Date: Tue, 26 Dec 2017 11:00:10 -0200
Message-Id: <20171226130011.26561-1-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements MMIO emulation for two instructions: lvx and stvx.

Thanks.

Jose Ricardo Ziviani (1):
  KVM: PPC: Book3S: Add MMIO emulation for VMX instructions

 arch/powerpc/include/asm/kvm_host.h   |   2 +
 arch/powerpc/include/asm/kvm_ppc.h    |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   6 ++
 arch/powerpc/kvm/emulate_loadstore.c  |  32 +++++++
 arch/powerpc/kvm/powerpc.c            | 162 ++++++++++++++++++++++++++++++----
 5 files changed, 189 insertions(+), 17 deletions(-)

-- 
2.14.1
