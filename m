Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76B611A089E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:38 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 6 Aug 2014 12:49:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 34443357805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s762VsQb27852996
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:31:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s762n58w020655
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:49:05 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] vfio: eeh: spapr: Compile and compatibility fixes
Date: Wed,  6 Aug 2014 12:48:29 +1000
Message-Id: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is what I have in my stash which would be nice to have in 3.17.

Alexey Kardashevskiy (2):
  vfio_spapr_eeh: Enable compile as a module
  vfio_pci: spapr: Enable VFIO if EEH is not supported

Gavin Shan (2):
  powerpc/eeh: Export eeh_iommu_group_to_pe()
  vfio: spapr: Fix build error

 arch/powerpc/kernel/eeh.c     |  1 +
 drivers/vfio/Makefile         |  4 ++--
 drivers/vfio/pci/vfio_pci.c   |  6 ++----
 drivers/vfio/vfio_spapr_eeh.c | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.0.0
