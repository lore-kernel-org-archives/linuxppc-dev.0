Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0F9CDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:17:50 +1100 (EST)
Date: Mon, 26 Nov 2007 16:17:42 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 0/3][RESEND] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII
	Timing)
Message-Id: <20071126161742.fcdfa762.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

these 3 patches are a resend of patches 2-4 (out of 5) that were
originally sent 2007-11-05* (patches 1 and 5 were picked up by Kumar
to go through powerpc).

Jeff, Leo has acked these, please consider for 2.6.24.

Thanks,

Kim

* http://marc.info/?l=linux-netdev&m=119428688804765&w=1
