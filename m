Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5DWz3SDGzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:35:43 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Thu, 12 May 2016 23:35:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C854D2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:35:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4CDZFul61407426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:35:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4CDYo7b014279
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:34:51 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, aik@au1.ibm.com,
 mpe@ellerman.id.au, Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH v2 0/2] Fix powerpc,numa: Fix memory_hotplug_max()
Date: Thu, 12 May 2016 19:04:13 +0530
Message-Id: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes memory_hotplug_max() routine to return correct
value of maximum hotpluggable address.

In this version, whitespace fixes are separated into a different patch.

v2: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg103342.html

Bharata B Rao (2):
  powerpc,numa: Fix whitespace in hot_add_drconf_memory_max()
  powerpc,numa: Fix memory_hotplug_max()

 arch/powerpc/mm/numa.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

-- 
2.1.0
