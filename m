Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id BAF76DDE34
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:11:49 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 7A75814355
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:12:56 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08735-10 for <linuxppc-dev@ozlabs.org>;
	Fri,  9 Nov 2007 18:12:55 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 4E2591431C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:12:55 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v4 00/13] [POWERPC] Add TQM5200/CM5200/Motion-PRO board support
To: linuxppc-dev@ozlabs.org
Date: Fri, 09 Nov 2007 18:11:37 +0100
Message-ID: <20071109171137.16289.39575.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a yet another version of the patches that add arch/powerpc support for
three MPC5200 based boards: TQ-Components TQM5200, Schindler CM5200
and Promess Motion-PRO.

Updates include modifications to mpc5200_simple_probe() routine in the
generic support for simple MPC5200 based boards, changes to
leds-motionpro driver - using common compatility property for both LEDs,
and few other .dts cleanups.

[POWERPC] Promess Motion-PRO defconfig
[POWERPC] Promess Motion-PRO DTS
[POWERPC] Motion-PRO: Add LED support.
[POWERPC] CM5200 defconfig
[POWERPC] CM5200 DTS
[POWERPC] TQM5200 defconfig
[POWERPC] TQM5200 DTS
[POWERPC] Use EXPORT_SYMBOL_GPL for 52xx common routines symbol export
[POWERPC] Export mpc52xx_map_node() routine symbol
[POWERPC] Add generic support for simple MPC5200 based boards
[POWERPC] Add common mpc52xx_setup_pci() routine
[POWERPC] Add 'fsl,lpb' bus type for MPC5200 LocalPlus Bus
[POWERPC] Add 'model: ...' line to common show_cpuinfo()

Please review, and if everything is ok schedule for 2.6.24-rc3.

Cheers,
m.
