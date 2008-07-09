Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CD12DDF96
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:54:14 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m69Ks7Mq016553
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 13:54:07 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4][Version 3] MPC5121 Updates
Date: Wed,  9 Jul 2008 14:54:00 -0600
Message-Id: <1215636844-32040-1-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches contain updates for MPC5121

1/4
    Updates the device tree.
    Addresses all comments received.
2/4
    Adds a clock driver. Cleanup based on input from Stephen Rothwell,
    and Grant Likely.  Also now uses the clock driver in
    arch/powerpc/kernel/clock.c instead of exporting api's directly.
3/4
    Adds support for generic boards.  This is nearly identical to
    David Jander's patch but does not delete the ADS board option.
    ADS is not a candidate for generic since it has an on board
    cpld that does pci interrupt routing.
4/4 
    Adds support for the CPLD on the MPC5121ADS board.
    Some minor changes based on input from Grant Likely.

This patchset does not include PCI support.  PCI support for 5121
needs mpc83xx_add_bridge to be moved to sysdev/fsl_pci.c.  That
change is in a different patch set.  I'll submit a 5121 PCI patch
after that different patch set gets committed.
