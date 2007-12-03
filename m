Return-Path: <b04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BA40DDF06
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:19:01 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 0/2] QE clock source improvements
Date: Mon,  3 Dec 2007 15:17:57 -0600
Message-Id: <11967166791607-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch set adds a new property to make specifying QE clock sources
easier, adds a function to help parse the property, and updates the ucc_geth
driver to take advantage of all this.

Patch #1 is an arch/powerpc patch meant for Kumar's for-2.6.25 branch.
Patch #2 is a netdev patch, so it's either for Jeff G and/or Kumar.
