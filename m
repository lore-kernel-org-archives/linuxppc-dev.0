Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pdt066cPzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 16:35:20 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id f7-v6so2419265plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 23:35:20 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCHv2 0/3] post the event cpux add/remove besides online/offline
 during hotplug
Date: Mon, 16 Apr 2018 14:35:05 +0800
Message-Id: <1523860508-19364-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1->v2:
   -1.improve the commit log and explain the reproducing of bug in [3/3]
   -2.re-fragment the series, and [3/3] is the motivation, while [1~2/3] are preparation.   

Pingfan Liu (3):
  powerpc/cpuidle: dynamically register/unregister cpuidle_device during
    hotplug
  powerpc/cpu: dynmamically to create/destroy the file physical_id
    during hotplug
  powerpc/cpu: post the event cpux add/remove instead of online/offline
    during hotplug

 arch/powerpc/include/asm/smp.h               |  1 +
 arch/powerpc/kernel/sysfs.c                  | 26 ++++++++++++++------------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  3 +++
 drivers/cpuidle/cpuidle-powernv.c            |  2 ++
 drivers/cpuidle/cpuidle-pseries.c            |  2 ++
 5 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.7.4
