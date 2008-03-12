Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15808DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 23:55:50 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m2CCte1F021086
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 18:25:40 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2CCteKt1163344
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 18:25:40 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m2CCtd3J022804
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 12:55:39 GMT
Message-ID: <47D7D2C9.4090001@linux.vnet.ibm.com>
Date: Wed, 12 Mar 2008 18:25:37 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [BUG] 2.6.25-rc5-mm1 kernel panic with "Exception: 501 " on powerpc
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
In-Reply-To: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The 2.6.25-rc5-mm1 kernel panics while bootup on powerpc

returning from prom_init
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc00000000000d5dc
cpu 0x0: Vector: 300 (Data Access) at [c0000000007636e0]
    pc: c00000000000d5dc: .do_IRQ+0x74/0x1f4
    lr: c00000000000d5a8: .do_IRQ+0x40/0x1f4
    sp: c000000000763960
   msr: 8000000000001032
   dar: 0
 dsisr: 40000000
  current = 0xc000000000688e60
  paca    = 0xc000000000689900
    pid   = 0, comm = swapper
enter ? for help
[c000000000763a00] c000000000004c24 hardware_interrupt_entry+0x24/0x28
--- Exception: 501 (Hardware Interrupt) at c0000000006021b0 .free_bootmem_core+0x94/0xcc
[link register   ] c00000000060373c .free_bootmem_with_active_regions+0x78/0xb8
[c000000000763cf0] c000000000602610 .init_bootmem_core+0x5c/0xfc (unreliable)
[c000000000763d80] c0000000005eb68c .do_init_bootmem+0x964/0xaf0
[c000000000763e50] c0000000005e03b0 .setup_arch+0x1a4/0x218
[c000000000763ee0] c0000000005d76bc .start_kernel+0xe8/0x424
[c000000000763f90] c000000000008590 .start_here_common+0x60/0xd0

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
