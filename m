Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 403B1B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 16:01:06 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [RFC 0/4] [flexcan/powerpc] Add support for powerpc flexcan
	(freescale p1010) -V7
Date: Tue,  9 Aug 2011 00:55:09 -0500
Message-Id: <1312869313-22434-1-git-send-email-holt@sgi.com>
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

I have compiled each patch in the series individually for both arm and
powerpc (cheated on ppc and reordered them with the last patch first so
I could select CAN_FLEXCAN.

With all the patches applied, my p1010rdb works for communicating between
its two can ports and also can communicate with an external PSOC.  I have
done no testing beyond compile testing on an arm system as I have no
access to an arm based system.

For the first three patches in the series, I believe they are all ready
for submission to David S. Miller for the netdev tree.  This is the
first submission of patch 4 which, I believe, will end up going through
the linuxppc-dev list and can go at any time after the flexcan patches
are submitted.  As long the first and last patches are both applied,
the tree will compile for either ppc or arm, but will not work without
all patches.  If the ppc patch (4/4) gets applied before 1/4, we could
have a random config tester detect a compile failure on ppc if they
select NET, CAN, and CAN_FLEXCAN.

Thanks,
Robin Holt
