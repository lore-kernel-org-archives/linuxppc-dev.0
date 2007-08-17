Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05E02DDD06
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 03:53:41 +1000 (EST)
Date: Fri, 17 Aug 2007 12:53:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 0/7] fs_enet patches
Message-ID: <20070817175320.GA8259@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

The following patchset includes several updates for the fs_enet driver,
the most prominent being conversion to an of_platform device (with
platform_device code remaining until arch/ppc goes away).  It also
includes a generic MDIO bitbang library, and converts fs_enet to use it.

I have a powerpc patch (ep8248e board support) that depends on the MDIO
bitbang library, so it may be better to ack them for Paul to pick up --
but if not, I can postpone the ep8248e patch until the merge window.

-Scott
