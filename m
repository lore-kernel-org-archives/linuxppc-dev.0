Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04104DDF2E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 02:58:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5KGwfrN024037
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 09:58:41 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/6] MPC5121 Updates
Date: Fri, 20 Jun 2008 10:58:33 -0600
Message-Id: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
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

1/6
    Updates the device tree.
2/6
    Adds a clock driver.
3/6
    Adds support for generic boards.  This is nearly identical to
    David Jander's patch but does not delete the ADS board option.
    ADS is not a candidate for generic since it has an on board
    cpld that does pci interrupt routing.
4/6 
    Adds support for the CPLD on the MPC5121ADS board.
5/6 
    Adds pci
6/6 
    Hides the pci bridge
