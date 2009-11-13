Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id DE1641007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 21:42:28 +1100 (EST)
From: Luotao Fu <l.fu@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [V2] Patches for mpc52xx_spi
Date: Fri, 13 Nov 2009 11:41:14 +0100
Message-Id: <1258108877-25435-1-git-send-email-l.fu@pengutronix.de>
In-Reply-To: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Grand,

here are the V2 of my patchset for mpc52xx_spi. Besides Wolframs suggestions I
also added some more fixes. Details of changes can be checked in the patch
header. Please do consider to apply the patches. The patch 1/2 e.g. fix bugs,
which prevent the driver to work in some cases, as seen on my board.

cheers
Luotao Fu
