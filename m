Return-Path: <yorksun@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83B85DDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 06:56:11 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: akpm@linux-foundation.org
Subject: [PATCH 0/2] Add virtual resolution and panning for Freescale DIU
Date: Wed, 13 Aug 2008 15:55:02 -0500
Message-Id: <12186609042933-git-send-email-yorksun@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch set adds virtual resolutoin suppport for Freescale DIU driver.
Applications such as fbset can set visible resolution and virtual resoltuion.
X window can use the virtual resolution if xorg.conf has the following option.

option virtual <vxres> <vyres>


The second patch fixes a bug of AOI position.

Regards,

York
