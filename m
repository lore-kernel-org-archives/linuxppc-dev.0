Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 1AC3DDDF05
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:13:28 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id F197414311
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:27 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15423-05 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:13:26 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id BF634142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:26 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 00/11] [POWERPC] Add TQM5200/CM5200/Motion-PRO board support
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:13:03 +0200
Message-ID: <20071023231302.29359.27417.stgit@hekate.izotz.org>
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

This is a reworked set of patches that adds arch/powerpc support for
three MPC5200 based boards: TQ-Components TQM5200, Schindler CM5200
and Promess Motion-PRO.

Besides board support there are also few more MPC5200 common patches
that include update to show_cpuinfo(), adding new 'lpb' bus,
moving lite pci init code to common routine and adding platform support
for 'generic-mpc5200' compatible boards. All the above mentioned boards
use this generic support.

[POWERPC] Promess Motion-PRO defconfig
[POWERPC] Promess Motion-PRO DTS
[POWERPC] Motion-PRO: Add LED support.
[POWERPC] CM5200 defconfig
[POWERPC] CM5200 DTS
[POWERPC] TQM5200 defconfig
[POWERPC] TQM5200 DTS
[POWERPC] Add generic support for MPC5200 based boards
[POWERPC] Add common mpc52xx_setup_pci() routine
[POWERPC] Add 'lpb' bus type for MPC5200 LocalPlus Bus
[POWERPC] Add 'machine: ...' line to common show_cpuinfo()

Will appreciate review comments.

Cheers,
m.
