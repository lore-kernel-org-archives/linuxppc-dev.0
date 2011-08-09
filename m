Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 61DA8B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 00:44:18 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [Patch 0/5] [flexcan/powerpc] Add support for powerpc flexcan
	(freescale p1010) -V9
Date: Tue,  9 Aug 2011 09:43:46 -0500
Message-Id: <1312901031-29887-1-git-send-email-holt@sgi.com>
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

Marc, Wolfgang or U Bhaskar,

This patch set should have all your comments included.  It is based on
the David S. Miller net-next-2.6 tree commit 19fd617.

This series adds a fifth patch which cleans up and corrects the device
bindigs for the fsl-flexcan nodes.

I have compiled each patch in the series individually for both arm and
powerpc (cheated on ppc and reordered them with the last patch first so
I could select CAN_FLEXCAN.

With all the patches applied, my p1010rdb works for communicating between
its two can ports and also can communicate with an external PSOC.  I have
done no testing beyond compile testing on an arm system as I have no
access to an arm based system.

For the first three patches in the series, I believe they are all ready
for forwarding to David S. Miller for the netdev tree.  I think patch
4 is ready for submission to the PPC85xx maintainer.  This is the
first submission of patch 5.

Thanks,
Robin Holt
