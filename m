Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id D60BFDDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 00:22:15 +1000 (EST)
Subject: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>,
	Li Yang-r58472 <LeoLi@freescale.com>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 16:22:09 +0200
Message-Id: <1181744529.30670.298.camel@gentoo-jocke.transmode.se>
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

Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
a Freescale 832x CPU gives me this:
 ifconfig eth2 up
 ucc_geth_startup: Can not allocate DPRAM memory for p_thread_data_tx.
 eth2: Cannot configure net device, aborting.
 SIOCSIFFLAGS: Cannot allocate memory

This worked in 2.6.20
