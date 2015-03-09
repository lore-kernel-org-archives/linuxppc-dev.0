Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6742E1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:18:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 9 Mar 2015 13:18:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A563F2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:18:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t293IFLR45154454
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:18:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t293HnlJ028427
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:17:49 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH 0/4] EEH Cleanup
Date: Mon,  9 Mar 2015 11:17:28 +0800
Message-Id: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Four patches to cleanup the EEH, in type, comment and logic.

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
