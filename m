Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3D040B7B74
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 20:12:36 +1100 (EST)
From: Luotao Fu <l.fu@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Patches for mpc52xx_spi
Date: Tue, 10 Nov 2009 10:12:06 +0100
Message-Id: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, l.fu@pengutronix.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Grant,

here are several patches for the dedicated spi controller on mpc5200 SOC. The
patchset contains two fixes and an enhancement. I noticed that your original V4
Patch is still pending for mainline. So I made the patches against the latest
version in your -next tree. Tested on a mpc5200b machine with 7 spi devices,
(cs lines are conntected to gpios) on 2.6.31, should work with latest kernel
also. Please review.

cheers
Luotao Fu
