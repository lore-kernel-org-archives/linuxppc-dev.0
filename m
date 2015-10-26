Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93A531A03A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 22:45:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 46C412BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QCid5o28180504
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:44:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QCiSrU004542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:44:28 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V2 0/3] perf/powerpc:Add ability to sample intr machine state
 in powerpc
Date: Mon, 26 Oct 2015 18:14:05 +0530
Message-Id: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This short patch series add the ability to sample the interrupted
machine state for each hardware sample

Anju (3):
  perf/powerpc:add ability to sample intr machine state in power
  tools/perf:Map the ID values with register names
  perf/powerpc:add support for sampling intr machine state 


 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/uapi/asm/perf_regs.h   |  55 +++++++++++++
 arch/powerpc/perf/Makefile                  |   1 +
 arch/powerpc/perf/perf_regs.c               |  87 ++++++++++++++++++++
 tools/perf/arch/powerpc/include/perf_regs.h | 118 ++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |   5 ++
 6 files changed, 267 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/perf/perf_regs.c
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

-- 
2.1.0
