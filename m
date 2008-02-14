Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 6A7CCDDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 03:36:34 +1100 (EST)
Subject: BUG: ucc_geth, MDIO only works for UCC3(ucc@2200) on MPC8321
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>,
	Kim Phillips <kim.phillips@freescale.com>, Li Yang <LeoLi@freescale.com>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 17:36:31 +0100
Message-Id: <1203006991.5419.64.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to use other UCC2 or UCC4 for ethernet instead of UCC3 makes MDIO
unusable. UCC2 can not find its PHY if not UCC3 is present too. Seems
like only UCC3 is able to drive the MDIO bus.

 Jocke
