Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54049DDD05
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:24:00 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6RINsRG012918
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:23:55 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6RINsfl016913
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:23:54 -0500 (CDT)
Subject: [PATCH 0/5] Remove unnecessary loops_per_jiffy initialization code
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185560634.8055.170.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Jul 2007 13:23:54 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series removes lingering jiffies initialization
code from several platforms.  Note that the first patch in
this series for the 86xx has been rebased to current top of
Paul's repository and replaces an earlier version.


 arch/powerpc/platforms/52xx/lite5200.c         |   13 ++-----------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c      |   13 -------------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |   13 -------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c      |   11 -----------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |   14 ++------------
 arch/powerpc/platforms/8xx/mpc86xads_setup.c   |   14 --------------
 arch/powerpc/platforms/8xx/mpc885ads_setup.c   |   14 --------------
 arch/powerpc/platforms/embedded6xx/holly.c     |   12 ------------
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    7 -------
 9 files changed, 4 insertions(+), 107 deletions(-)
