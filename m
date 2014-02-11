Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD4CE2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:02:02 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 17:01:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EDA602BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:01:57 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B6gLLl66387986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 17:42:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B71ui8005084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:01:56 +1100
Subject: [PATCH v1 0/2] powernv: cpufreq support for IBM POWERNV platform
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Tue, 11 Feb 2014 12:31:52 +0530
Message-ID: <20140211065757.21159.49689.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following patch series implements the platform driver to support
dynamic CPU frequency scaling on IBM POWERNV platforms.

This patch series is based on Linux kernel 3.14-rc2 and tested on
OPAL v3 based IBM POWERNV platform and IBM POWER8 processor.

--Vaidy

---

Srivatsa S. Bhat (1):
      powernv, cpufreq: Add per-core locking to serialize frequency transitions

Vaidyanathan Srinivasan (1):
      powernv: cpufreq driver for powernv platform


 arch/powerpc/include/asm/reg.h    |    4 +
 drivers/cpufreq/Kconfig.powerpc   |    9 +
 drivers/cpufreq/Makefile          |    1 
 drivers/cpufreq/powernv-cpufreq.c |  286 +++++++++++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
