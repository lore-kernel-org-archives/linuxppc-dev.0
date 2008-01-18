Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2AFEDDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 19:36:13 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0I8a1io012784
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 14:06:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0I8a1CI794758
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 14:06:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0I8a3xf000424
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 08:36:04 GMT
Message-ID: <479064F0.7040305@linux.vnet.ibm.com>
Date: Fri, 18 Jan 2008 14:06:00 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc8-mm1 Kernel oops will running kernbench
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

Following oops was seen while running kernbench on one of test machine
(power4+ box). I tried reproducing the oops but was unsuccessful. 
I will try to reproduce the oops with debug info compiled.


Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 NUMA pSeries
Modules linked in:
NIP: 0000000000004570 LR: 000000000fc42dc0 CTR: 0000000000000000
REGS: c00000077b6bf8c0 TRAP: 0300   Not tainted  (2.6.24-rc8-mm1-autotest)
MSR: 8000000000001000 <ME>  CR: 28022422  XER: 00000000
DAR: c00000077b6bfce0, DSISR: 000000000a000000
TASK = c000000773164c40[19588] 'as' THREAD: c00000077b6bc000 CPU: 1
GPR00: 0000000000004000 c00000077b6bfb40 0000000000007346 000000000000d032 
GPR04: 000000000000043a 0000000000000000 000000000000000c 0000000000000004 
GPR08: 000000000fd278c8 0000000048022424 c00000077b6bfe30 0000998be2321500 
GPR12: 8000000000001030 c0000000005f6280 0000000010030000 0000000010030000 
GPR16: 0000000010030000 0000000010050000 000000001006aac0 0000000010053cd0 
GPR20: 0000000000000000 0000000000000fe0 0000000010050000 0000000010050000 
GPR24: 0000000000000ff8 0000000000000fe8 0000000000000062 000000000fd27490 
GPR28: 000000000fd274c8 0000000010099420 000000000fd25ff4 000000001009a400 
NIP [0000000000004570] 0x4570
LR [000000000fc42dc0] 0xfc42dc0
Call Trace:
[c00000077b6bfb40] [c00000077b292000] 0xc00000077b292000 (unreliable)
Instruction dump:
48000000 XXXXXXXX XXXXXXXX XXXXXXXX 41820008 XXXXXXXX XXXXXXXX XXXXXXXX 
48000010 XXXXXXXX XXXXXXXX XXXXXXXX f92101a0 XXXXXXXX XXXXXXXX XXXXXXXX 

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
