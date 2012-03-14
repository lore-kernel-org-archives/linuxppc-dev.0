Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F507B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 21:24:05 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Wed, 14 Mar 2012 15:53:56 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2EAMq80962692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 15:52:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2EFrEHH004484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 02:53:15 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 0/2] Kdump support for PPC_47x
To: jwboyer@gmail.com
Date: Wed, 14 Mar 2012 15:52:30 +0530
Message-ID: <20120314102121.675.92862.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
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

I have tested these patches on simics simulator for ppc476.

---

Suzuki K. Poulose (2):
      [47x] Enable CRASH_DUMP
      [47x] Kernel support for KEXEC


 arch/powerpc/Kconfig          |    4 -
 arch/powerpc/kernel/misc_32.S |  197 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 193 insertions(+), 8 deletions(-)

-- 
Suzuki K. Poulose
