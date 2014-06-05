Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62CFD1A02A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 17:25:53 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 5 Jun 2014 17:25:51 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4D4DB2BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 17:25:47 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5579n1E21168374
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 17:09:49 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s557PkIk023946
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 17:25:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Prepare for in-kernel VFIO DMA operations acceleration
Date: Thu,  5 Jun 2014 17:25:41 +1000
Message-Id: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reserves 2 capability numbers.

This implements an extended version of KVM_CREATE_SPAPR_TCE_64 ioctl.

Please advise how to proceed with these patches as I suspect that
first two should go via Paolo's tree while the last one via Alex Graf's tree
(correct?).

Thanks!

Alexey Kardashevskiy (3):
  PPC: KVM: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
  PPC: KVM: Reserve KVM_CAP_SPAPR_TCE_64 capability number
  PPC: KVM: Add support for 64bit TCE windows

 Documentation/virtual/kvm/api.txt   | 46 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h |  4 +++-
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/include/uapi/asm/kvm.h |  9 ++++++++
 arch/powerpc/kvm/book3s_64_vio.c    |  4 +++-
 arch/powerpc/kvm/powerpc.c          | 24 ++++++++++++++++++-
 include/uapi/linux/kvm.h            |  4 ++++
 7 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.0.0
