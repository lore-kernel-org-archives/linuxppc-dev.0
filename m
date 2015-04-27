Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E8DE1A0271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:26:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 11:26:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 76304357804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:26:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R1Pxl423462136
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:26:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R1PY99005957
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:25:34 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH V2 0/4] EEH Cleanup
Date: Mon, 27 Apr 2015 09:25:08 +0800
Message-Id: <1430097912-6207-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Four patches to cleanup the EEH, in type, comment and logic

---
v2:
   * rebased on the latest kernel

Wei Yang (4):
  powerpc/eeh: fix start/end/flags type in struct pci_io_addr_range{}
  powerpc/eeh: fix comment for wait_state()
  powerpc/eeh: fix powernv_eeh_wait_state delay logic
  powerpc/eeh: remove unused macro IS_BRIDGE

 arch/powerpc/kernel/eeh.c                    |    2 --
 arch/powerpc/kernel/eeh_cache.c              |   16 ++++++++--------
 arch/powerpc/kernel/eeh_driver.c             |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |    4 ++--
 arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
 5 files changed, 12 insertions(+), 14 deletions(-)

-- 
1.7.9.5
