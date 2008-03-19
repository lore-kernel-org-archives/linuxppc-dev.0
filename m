Return-Path: <york@linux224.somerset.sps.mot.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9EAE8DE015
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 05:50:33 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2JIoSIh021333
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 11:50:28 -0700 (MST)
Received: from linux224.somerset.sps.mot.com ([163.12.81.191])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m2JIoRuc007832
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 13:50:28 -0500 (CDT)
From: York Sun <yorksun@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: v2 patch for Freescale DIU driver
Date: Wed, 19 Mar 2008 13:50:25 -0500
Message-Id: <12059526271941-git-send-email-yorksun@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is the version 2 patch for Freescale DIU driver. Thanks for all the feedback.

The first patch is the driver. The second patch adds platform support for MPC8610HPCD board.
To compile, enable the "Freescale MPC8610/MPC5121 DIU framebuffer support" in the menuconfig.
