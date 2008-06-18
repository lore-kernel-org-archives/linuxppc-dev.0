Return-Path: <jrigby@FREESCALE.COM>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9556DE084
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:52:03 +1000 (EST)
From: John Rigby <jrigby@FREESCALE.COM>
To: Scott Wood <scottwood@FREESCALE.COM>, linuxppc-dev@ozlabs.org,
	jeff@garzik.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/2][Rev4] Add MPC5121 FEC suppport
Date: Wed, 18 Jun 2008 09:15:52 -0600
Message-Id: <1213802154-28968-1-git-send-email-jrigby@freescale.com>
Cc: netdev@vger.kernel.org, John Rigby <jrigby@FREESCALE.COM>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Changes since last patch set:
    This patch no longer assmues Kumar's patch that
    removes CONFIG_PPC_CPM_NEW_BINDING stuff.  That was just
    confusing.

    No checkpatch.pl fixes.

    Addresses all comments to previous patch.

    Does not rework the Kconfig logic.  More work is need than what
    was discussed to make this work when compiling as module.

Part 1/2 changes fec_t to struct fec.

Part 2/2 adds 5121 support.
