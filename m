Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7EC21A04C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 17:35:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 16:35:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 19C862CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 17:35:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t156ZCIm24313876
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 17:35:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t156YlFX011832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 17:34:47 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH 0/3] Code adjustment on pci/virtualization
Date: Thu,  5 Feb 2015 14:34:22 +0800
Message-Id: <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20150204234442.GC20072@google.com>
References: <20150204234442.GC20072@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn,

I had a try on your pci/virtualization branch, it works fine after applying
following three patches. The reason is written in the change log. And I have
tried, they could apply cleanly with the original one.

For the pnv_pci_ioda_fixup_sriov(), which you suggest to merge in sriov_init()
I found it is not that simple. Maybe I misunderstand your meaning.

I will be online tonight to see what else we can improve. Thanks for your time
:-)

Wei Yang (3):
  fix on Store individual VF BAR size in struct pci_sriov
  fix Reserve additional space for IOV BAR, with m64_per_iov supported
  remove the unused end in pnv_pci_vf_resource_shift()

 arch/powerpc/platforms/powernv/pci-ioda.c |    6 +++---
 drivers/pci/iov.c                         |    6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
1.7.9.5
