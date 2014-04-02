Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7145140130
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 09:11:05 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 2 Apr 2014 18:11:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id ED5986E8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 18:10:53 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s32MAxCZ9306578
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 22:11:00 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s32MAw8B009647
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Apr 2014 18:10:59 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 0/2] powerpc/perf: fixup 2 patches from the 24x7 series
Date: Wed,  2 Apr 2014 15:10:52 -0700
Message-Id: <1396476654-20623-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>, cody+local@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpe: these are fixups for 2 patches already in your merge tree (and in benh's next branch).

f3e622941a7cec587c00c0d17ea31514457c63c8 powerpc/perf: Add support for the hv 24x7 interface
edd354ea4a6774bf9f380b0acf30e699070f4e8a powerpc/perf: Add support for the hv gpci (get performance counter info) interface

The only change is to a pr_info() printed when the interface is not detected.

Anton: I'm hesitant to switch these to pr_debug() as they are the only way
users expecting these PMUs to exist to tell why the kernel decided they didn't
have them. As a result, I've kept them as pr_info() instead of converting to
pr_debug().


Cody P Schafer (2):
  fixup: "powerpc/perf: Add support for the hv 24x7 interface"
  fixup: "powerpc/perf: Add support for the hv gpci (get performance
    counter info) interface"

 arch/powerpc/perf/hv-24x7.c | 2 +-
 arch/powerpc/perf/hv-gpci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1
