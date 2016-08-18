Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFGDl2VzKzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 16:20:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7I6IiEa144001
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 02:20:36 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vmf1177g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 02:20:36 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 00:20:35 -0600
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PowerPC] today's main line failed to build on PowerPC
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, ego@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Date: Thu, 18 Aug 2016 11:50:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fcd669dc-7ad2-aeff-fb66-14c06c4f9a7d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The main line stable 4.8.0-rc2 failed to build on PowerPC with following 
build errors. config : pseries_le_defconfig Machine Type : PowerPC Bare 
Metal

09:34:22 00:04:59 INFO | make -j 160  vmlinux
09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S: Assembler messages:
09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:353: Error: missing operand
09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:612: Error: missing operand
09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:670: Error: missing operand
09:34:24 00:05:01 ERROR| [stderr] make[1]: *** [arch/powerpc/mm/hash_low_32.o] Error 1
09:34:24 00:05:01 ERROR| [stderr] make[1]: *** Waiting for unfinished jobs....
09:34:25 00:05:02 ERROR| [stderr] arch/powerpc/kernel/head_32.S: Assembler messages:
09:34:25 00:05:02 ERROR| [stderr] arch/powerpc/kernel/head_32.S:1113: Error: missing operand
09:34:25 00:05:02 ERROR| [stderr] make[1]: *** [arch/powerpc/kernel/head_32.o] Error 1
09:34:25 00:05:02 ERROR| [stderr] make[1]: *** Waiting for unfinished jobs....
09:34:27 00:05:04 ERROR| [stderr] make: *** [arch/powerpc/mm] Error 2
09:34:27 00:05:04 ERROR| [stderr] make: *** Waiting for unfinished jobs....
09:34:42 00:05:19 ERROR| [stderr] make: *** [arch/powerpc/kernel] Error 2

Regard's
Abdul
