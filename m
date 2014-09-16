Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 737351A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 06:15:57 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 16 Sep 2014 14:15:55 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 02DFA19D8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:40 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8GKFrUH50856058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 22:15:53 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8GKFpmD015037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:53 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] pseries: Make CPU hotplug and hotremove endian safe
Date: Tue, 16 Sep 2014 15:15:44 -0500
Message-Id: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset ensures that cpu hotplugging and hotremoval are 
compatible with both big and little endian architectures.  

Bharata B Rao (1):
  pseries: Make CPU hotplug path endian safe

Thomas Falcon (2):
  pseries: Fix endian issues in onlining cpu threads
  pseries: Fix endian issues in cpu hot-removal

 arch/powerpc/platforms/pseries/dlpar.c       | 50 +++++++++++++++-------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 14 ++++----
 arch/powerpc/platforms/pseries/pseries.h     |  3 +-
 3 files changed, 37 insertions(+), 30 deletions(-)

-- 
1.8.5.2
