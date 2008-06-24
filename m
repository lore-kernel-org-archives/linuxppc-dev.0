Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FCA1DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:24:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5OLOYe1001896
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 14:24:34 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8][Version 2] MPC5121 Updates
Date: Tue, 24 Jun 2008 15:24:24 -0600
Message-Id: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
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

1/8
    No change since last submission.
    Updates the device tree.
2/8
    Adds a clock driver. Cleanup based on input from Stephen Rothwell.
3/8
    No change since last submission.
    Adds support for generic boards.  This is nearly identical to
    David Jander's patch but does not delete the ADS board option.
    ADS is not a candidate for generic since it has an on board
    cpld that does pci interrupt routing.
4/8 
    No change since last submission.
    Adds support for the CPLD on the MPC5121ADS board.
5/8 
    Cleans up pci config in arch/powerpc/Kconfig to make it
    less messy to add an new platform that has pci.
6/8 
    Moves mpc83xx_add_bridge from a/p/p/83xx/pci.c to
    a/p/p/sysdev/fsl_pci.c. So it can be used by other platforms
    using the same pci core.
7/8 
    Adds pci support for mpc5121 and uses mpc83xx_add_bridge.
8/8 
    No change since last submission (except now 8/8 instead of 6/6).
    Hides the pci bridge
