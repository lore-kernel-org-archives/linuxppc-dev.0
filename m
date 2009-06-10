Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5CBC5B70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 13:55:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8B39DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 13:55:49 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5A3tiVn023062
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jun 2009 22:55:45 -0500
Subject: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 13:14:38 +1000
Message-Id: <1244603678.2431.18.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi !

I've updated my "next" branch with the following patches. We're getting
real close to the merge window now, so if something is missing, please
holler ASAP.

Cheers,
Ben.

Becky Bruce (1):
      powerpc: Add support for swiotlb on 32-bit

Benjamin Herrenschmidt (8):
      powerpc/mm: Fix some SMP issues with MMU context handling
      powerpc/mm: Fix a AB->BA deadlock scenario with nohash MMU context lock
      powerpc: Set init_bootmem_done on NUMA platforms as well
      powerpc: Move VMX and VSX asm code to vector.S
      powerpc: Introduce CONFIG_PPC_BOOK3S
      powerpc: Split exception handling out of head_64.S
      powerpc: Separate PACA fields for server CPUs
      powerpc: Shield code specific to 64-bit server processors

Grant Likely (1):
      powerpc/virtex: refactor intc driver and add support for i8259 cascading

John Linn (1):
      fbdev: Add PLB support and cleanup DCR in xilinxfb driver.

Roderick Colenbrander (3):
      powerpc/virtex: Add support for Xilinx PCI host bridge
      powerpc/virtex: Add Xilinx ML510 reference design support
      powerpc/virtex: Add ml510 reference design device tree

Roland McGrath (1):
      powerpc: Add PTRACE_SINGLEBLOCK support

Stephen Rothwell (4):
      powerpc/pseries: Fix warnings when printing resource_size_t
      powerpc/xmon: Remove unused variable in xmon.c
      powerpc: Fix warning when printing a resource_size_t
      powerpc/spufs: Remove unused error path
