Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C6C81A021C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:30:03 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 5 Aug 2014 22:30:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 559102BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:29:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75CUTnk12583152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:30:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75CTtLN016648
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:29:55 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] vfio: eeh: spapr: Compile and compatibility fixes
Date: Tue,  5 Aug 2014 22:29:41 +1000
Message-Id: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is what I have in my stash.

Alexey Kardashevskiy (2):
  vfio_spapr_eeh: Enable compile as a module
  vfio_pci: spapr: Enable VFIO if EEH is not supported

Gavin Shan (2):
  powerpc/eeh: Export eeh_iommu_group_to_pe()
  vfio: spapr: Fix build error

 arch/powerpc/kernel/eeh.c     |  1 +
 drivers/vfio/Makefile         |  4 ++--
 drivers/vfio/pci/vfio_pci.c   |  6 ++----
 drivers/vfio/vfio.c           |  1 +
 drivers/vfio/vfio_spapr_eeh.c | 16 ++++++++++++++++
 5 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.0.0
