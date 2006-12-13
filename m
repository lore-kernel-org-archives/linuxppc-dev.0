Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 54D4367C20
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 23:44:49 +1100 (EST)
Subject: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: netdev@vger.kernel.org
Content-Type: text/plain
Date: Wed, 13 Dec 2006 13:44:47 +0100
Message-Id: <1166013887.30422.54.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/net/ucc_geth.c:4083:45: macro "INIT_WORK" passed 3 arguments,
but takes just 2
drivers/net/ucc_geth.c: In function `ucc_geth_open':
drivers/net/ucc_geth.c:4083: error: `INIT_WORK' undeclared (first use in
this function)
drivers/net/ucc_geth.c:4083: error: (Each undeclared identifier is
reported only once
drivers/net/ucc_geth.c:4083: error: for each function it appears in.)
drivers/net/ucc_geth.c: At top level:
drivers/net/ucc_geth.c:3924: warning: 'ugeth_phy_change' defined but not
used
make[2]: *** [drivers/net/ucc_geth.o] Error 1

drivers/net/ucc_geth_phy.c:71: error: conflicting types for 'phy_read'
include/linux/phy.h:355: error: previous declaration of 'phy_read' was
here
drivers/net/ucc_geth_phy.c:71: error: conflicting types for 'phy_read'
include/linux/phy.h:355: error: previous declaration of 'phy_read' was
here
drivers/net/ucc_geth_phy.c:72: error: conflicting types for 'phy_write'
include/linux/phy.h:356: error: previous declaration of 'phy_write' was
here
drivers/net/ucc_geth_phy.c:72: error: conflicting types for 'phy_write'
include/linux/phy.h:356: error: previous declaration of 'phy_write' was
here
