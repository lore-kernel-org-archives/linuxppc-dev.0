Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60B44B7032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:27:09 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 16 Apr 2012 08:22:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3G8R6O414745768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:27:06 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3G8R5P3017255
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:27:06 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 0/2] Kdump support for 47x
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 16 Apr 2012 13:56:52 +0530
Message-ID: <20120416082449.27331.12488.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series implements Kexec/Kdump support for
PPC_47x based platforms. Doesn't support SMP yet.

I have tested these patches on the following simulators:
        1) simics
        2) IBM ISS for ppc476.

Changes since V1:
 * Initialize the SPRN_PID to kernel pid (0) before the TLB operations in
   setup_map_47x


---

Suzuki K. Poulose (2):
      [47x] Enable CRASH_DUMP
      [47x] Kernel support for KEXEC


 arch/powerpc/Kconfig          |    4 -
 arch/powerpc/kernel/misc_32.S |  195 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 8 deletions(-)

-- 
Suzuki K. Poulose
