Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 2AC46DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 10:52:18 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 000401432E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 00:52:52 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02340-10 for <linuxppc-dev@ozlabs.org>;
	Sun,  4 Nov 2007 00:52:52 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 4BE7D142CC
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 00:52:52 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2 00/12] [POWERPC] Add TQM5200/CM5200/Motion-PRO board support
To: linuxppc-dev@ozlabs.org
Date: Sun, 04 Nov 2007 00:52:10 +0100
Message-ID: <20071103235210.31906.83423.stgit@hekate.izotz.org>
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

This is a secon respin of the patches that add arch/powerpc support for
three MPC5200 based boards: TQ-Components TQM5200, Schindler CM5200
and Promess Motion-PRO. Please review.

[POWERPC] Promess Motion-PRO defconfig
[POWERPC] Promess Motion-PRO DTS
[POWERPC] Motion-PRO: Add LED support.
[POWERPC] CM5200 defconfig
[POWERPC] CM5200 DTS
[POWERPC] TQM5200 defconfig
[POWERPC] TQM5200 DTS
[POWERPC] Export mpc52xx_map_node() routine symbol
[POWERPC] Add generic support for simple MPC5200 based boards
[POWERPC] Add common mpc52xx_setup_pci() routine
[POWERPC] Add 'fsl,lpb' bus type for MPC5200 LocalPlus Bus
[POWERPC] Add 'model: ...' line to common show_cpuinfo()

Cheers,
m.
