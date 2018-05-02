Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40bPrb6HrPzF2Rn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 14:07:59 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 0/2] KVM: PPC: Allow backing bigger guest IOMMU pages
 with smaller physical
Date: Wed,  2 May 2018 14:07:21 +1000
Message-Id: <20180502040723.20545-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to allow the guest to use big host IOMMU pages even when
the exact page size (i.e. 16MB) is not supported by the host (i.e.P9).


Please comment. Thanks.



Alexey Kardashevskiy (2):
  KVM: PPC: Use correct page shift in H_STUFF_TCE
  KVM: PPC: Allow backing bigger guest IOMMU pages with smaller physical
    pages

 arch/powerpc/kvm/book3s_64_vio.c    | 68 +++++++++++++++++++++++++++++--------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 54 +++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 22 deletions(-)

-- 
2.11.0
