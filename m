Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6615DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 17:21:30 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n246LN0W002233
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Mar 2009 00:21:24 -0600
Subject: new batch in "test"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 17:21:22 +1100
Message-Id: <1236147682.6696.37.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Holler if something is wrong...

Here's what I just stick in "test", to hit "next" one of these days.

Arnd Bergmann (1):
      powerpc/spufs: Initialize ctx->stats.tstamp correctly

Benjamin Herrenschmidt (6):
      powerpc: Wire up /proc/vmallocinfo to our ioremap()
      powerpc/kconfig: Kill PPC_MULTIPLATFORM
      powerpc: Split the various pgtable-* headers based on MMU type
      powerpc/mm: Unify PTE_RPN_SHIFT and _PAGE_CHG_MASK definitions
      powerpc/mm: Tweak PTE bit combination definitions
      powerpc/mm: Merge various PTE bits and accessors definitions

Geoff Levand (2):
      powerpc: Add missing DABR flags
      powerpc/ps3: Print memory hotplug errors

Michael Ellerman (3):
      powerpc: Deindentify identify_cpu()
      powerpc: Make sure we copy all cpu_spec features except PMC related ones
      powerpc: Remove unused asm-offsets entries for cpu_spec

Nick Piggin (1):
      powerpc: Estimate G5 cpufreq transition latency

Octavian Purdila (1):
      powerpc/oprofile: G4 oprofile has variable number of counters

Timur Tabi (1):
      powerpc: Add defintion for MSR[GS] to list of MSR bits

roel kluin (1):
      powerpc/ps3: Make ps3av_set_video_mode mode ID signed
