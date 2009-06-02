Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9331DDDE2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 13:03:53 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5233nPf009270
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Jun 2009 22:03:50 -0500
Subject: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Jun 2009 13:03:48 +1000
Message-Id: <1243911828.5308.2.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've updated powerpc "next branch" with the following patches:

(Kumar: The swiotlb patch is still segregated in "test" until we resolve
how it's going to be merged vs. Ian Campbell series).

Anton Blanchard (1):
      powerpc: Convert RTAS event scan from kernel thread to workqueue

Michael Ellerman (3):
      powerpc/ftrace: Use ppc_function_entry() instead of GET_ADDR
      powerpc/ftrace: Remove unused macros
      powerpc/ftrace: Use PPC_INST_NOP directly

Michael Neuling (1):
      powerpc: Make the NR_CPUS max 8192

Michel Dänzer (1):
      therm_adt746x: Always clear hardware bit which inverts fan speed range.

Nathan Fontenot (1):
      powerpc: Display processor virtualization resource allocs in lparcfg

Stephen Rothwell (1):
      powerpc/pci: Fix annotation of pcibios_claim_one_bus

roel kluin (1):
      tape: beyond ARRAY_SIZE of viocd_diskinfo
