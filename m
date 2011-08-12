Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id A8129B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 18:46:03 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH v12 0/6] flexcan/powerpc: Add support for powerpc flexcan
	(freescale p1010)
Date: Fri, 12 Aug 2011 03:45:46 -0500
Message-Id: <1313138752-24006-1-git-send-email-holt@sgi.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	PPC list <linuxppc-dev@lists.ozlabs.org>, Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With all the patches applied, my p1010rdb works for communicating between
its two can ports and also can communicate with an external PSOC.
I have done no testing beyond compile testing for an arm system as I
have no access to an arm based system.

With the latest version, changes to the arch tree really only reflect
changes in the drivers/net/can tree.  I, therefore, believe it is
probably best to route them through David S. Miller's netdev tree.
Wolfgang and Kumar, does that seem correct to you?

Thanks,
Robin Holt
