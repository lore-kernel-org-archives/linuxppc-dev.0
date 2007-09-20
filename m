Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F39B2DDF07
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 08:01:18 +1000 (EST)
Date: Thu, 20 Sep 2007 17:00:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 0/9] fs enet and mdio bitbang patches
Message-ID: <20070920220043.GA28769@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Changes since previous patchset:

- Changed mdio_bitbang_ to mdiobb_, as requested.
- Separated mii bitbang conversion to generic MDIO bitbang library from the
  of_platform conversion.
- Added register read-backs to flush the writes in mdio bitbang clients.
- Fixed a couple minor issues.

Jeff, please apply for 2.6.24.

-Scott
