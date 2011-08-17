Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 0D679B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Aug 2011 13:32:36 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, "David S. Miller" <davem@davemloft.net>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan (freescale
	p1010)
Date: Tue, 16 Aug 2011 22:32:18 -0500
Message-Id: <1313551944-28603-1-git-send-email-holt@sgi.com>
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

David,

The following set of patches have been reviewed by the above parties and
all comments have been integrated.  Although the patches stray from the
drivers/net/can directory, the diversions are related to changes for
the flexcan driver.

The patch set is based upon your net-next-2.6 tree's commit 6c37e46.

Could you please queue these up for the next appropriate push to Linus'
tree?

Thanks,
Robin Holt
