Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz10Y1BfmzDr4M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:44 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TDYT9x093012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:42 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bd28293vr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 09:36:42 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 23:36:38 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TDaQgi8061378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TDa206000351
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:36:02 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] A fix and a few new tests for kprobe tracer
Date: Thu, 29 Jun 2017 19:05:35 +0530
Message-Id: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1427923.html

Changes since v1:
  - Patch 1 is unchanged from v1.
  - Patch 3 drops change to include dot symbols, as suggested by Masami.
  - Patches 2 and 4 implement new test cases to cover these scenarios

Thanks,
Naveen


Masami Hiramatsu (1):
  selftests/ftrace: Add a testcase for kprobe event naming

Naveen N. Rao (3):
  trace/kprobes: Sanitize derived event names
  selftests/ftrace: Add a test to probe module functions
  selftests/ftrace: Update multiple kprobes test for powerpc

 kernel/trace/trace_kprobe.c                        |  9 ++++++
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       | 32 ++++++++++++++++++++++
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |  4 +--
 .../selftests/ftrace/test.d/kprobe/probe_module.tc | 14 ++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc

-- 
2.13.1
