Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54956DDFD1
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 17:44:10 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4T7i4XV004049
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 02:44:06 -0500
Subject: A few more things in -test
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 May 2009 17:44:04 +1000
Message-Id: <1243583044.17903.40.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I pushed out a few more things in -test. I'll do a new -next with these
and maybe a couple of other things on monday hopefully.

Anton Blanchard (1):
      powerpc: Convert RTAS event scan from kernel thread to workqueue

Becky Bruce (1):
      powerpc: Add support for swiotlb

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

roel kluin (1):
      tape: beyond ARRAY_SIZE of viocd_diskinfo
