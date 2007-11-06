Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 1C631DDECC
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:04:58 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 09C7714399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:05:49 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09143-07 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:05:48 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id B7C7814377
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:05:46 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 00/13] [POWERPC] Add TQM5200/CM5200/Motion-PRO board support
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:04:47 +0100
Message-ID: <20071106200446.10913.29338.stgit@hekate.izotz.org>
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

This is a third version of the patches that add arch/powerpc support for
three MPC5200 based boards: TQ-Components TQM5200, Schindler CM5200
and Promess Motion-PRO.

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

Please review them and schedule for 2.6.24-rc2 if you are ok with them.

Cheers,
m.
