Return-Path: <york@linux224.somerset.sps.mot.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EA94DE074
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 08:43:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2CLhhWg017930
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 14:43:44 -0700 (MST)
Received: from linux224.somerset.sps.mot.com ([163.12.81.191])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2CLhhQv013609
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 16:43:43 -0500 (CDT)
From: York Sun <yorksun@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: Driver for Freescale Display Interface Unit (A LCD controller)
Date: Wed, 12 Mar 2008 16:43:41 -0500
Message-Id: <12053582234100-git-send-email-yorksun@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patches are for Freescale DIU. The first patch is a DIU driver.
The second patch is the platform code to support the driver. It is a frame
buffer driver for DIU. Descriptions can be found in the patches.

It is a new feature targeting 2.6.26 kernel.
