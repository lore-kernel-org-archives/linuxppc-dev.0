Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0005DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 05:56:52 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] ASoC drivers for the Freescale MPC8610 SoC
Date: Mon,  7 Jan 2008 12:56:42 -0600
Message-Id: <1199732204949-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


These patches add ALSA SoC device drivers for the Freescale MPC8610 SoC
and the MPC8610-HPCD reference board.

The first patch updates some files in arch/powerpc and booting-without-of.txt.

The second patch adds the new audio driver files to sound/soc.

Both must be applied in order to avoid a build break.
