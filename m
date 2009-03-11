Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44D6ADDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 17:25:35 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2B6PTuj001788
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 01:25:30 -0500
Subject: nest branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:25:28 +1100
Message-Id: <1236752728.7086.44.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following commits have been added to powerpc next:

Anton Vorontsov (1):
      powerpc/83xx: Do not configure or probe disabled FSL DR USB controllers

Arnd Bergmann (1):
      powerpc/spufs: Initialize ctx->stats.tstamp correctly

Benjamin Herrenschmidt (1):
      powerpc: Wire up /proc/vmallocinfo to our ioremap()

Geoff Levand (2):
      powerpc: Add missing DABR flags
      powerpc/ps3: Print memory hotplug errors

Grant Likely (2):
      powerpc/5200: Add 'simple-bus' to the of_platform probe list.
      powerpc/4xx: update ml507 .dts file to release reference design

Grzegorz Bernacki (2):
      powerpc/5200: Add digsy-mtc support to mpc5200_defconfig
      powerpc/5200: On the digsy-mtc, configure PSC4 and PSC5 as UARTs

Kumar Gala (1):
      powerpc/fsl-booke: Add support for tlbilx instructions

Martyn Welch (1):
      powerpc/86xx: Correct local bus registers in GE Fanuc SBC610 dts file

Michael Ellerman (3):
      powerpc: Deindentify identify_cpu()
      powerpc: Make sure we copy all cpu_spec features except PMC related ones
      powerpc: Remove unused asm-offsets entries for cpu_spec

Nick Piggin (1):
      powerpc: Estimate G5 cpufreq transition latency

Octavian Purdila (1):
      powerpc/oprofile: G4 oprofile has variable number of counters

Timur Tabi (3):
      i2c-mpc: do not allow interruptions when waiting for I2C to complete
      powerpc: add fsl,fifo-depth property to Freescale SSI device nodes
      powerpc: Add defintion for MSR[GS] to list of MSR bits

Xiaotian Feng (1):
      cpm_uart: fix non-console port startup bug

dayu@datangmobile.cn (1):
      powerpc/83xx: Fix the interrupt loss problem on ipic

roel kluin (1):
      powerpc/ps3: Make ps3av_set_video_mode mode ID signed
