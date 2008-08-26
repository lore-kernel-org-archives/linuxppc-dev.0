Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CF2A8DE6DB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 23:14:00 +1000 (EST)
Received: from int-nj2ut-2.online-age.net (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7QDDurQ017096
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 09:13:56 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by int-nj2ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7QDDp1w002015
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 09:13:56 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v3 0/2] powerpc: Board support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Tue, 26 Aug 2008 09:13:39 -0400
Message-ID: <20080826131339.12883.61796.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: scottwood@freescale.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements basic board support for GE Fanuc's SBC610, a 
6U single board computer, based on Freescale's MPC8641D.

This series provides basic functionality:
- The board can boot with a serial console.
- Ethernet works, though the phys are polled.
- The PCI bus is scanned and sata functions.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

Kumar & Scott: Thanks again for your comments.

I have:
- Removed all of the "device_type" entries I believe I can
- Moved the default config to new directory "arch/powerpc/configs/86xx/"
- "mac-address" changed to "local-mac-address"
- Removed un-needed #add/size and other defunct entries
- Use common interrupt routine.

Martyn

Martyn Welch (2):
      powerpc: Default configuration for GE Fanuc SBC610
      powerpc: Board support for GE Fanuc SBC610


 arch/powerpc/boot/dts/gef_sbc610.dts      |  268 +++++
 arch/powerpc/configs/gef_sbc610_defconfig | 1654 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig       |    9 
 arch/powerpc/platforms/86xx/Makefile      |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c  |  187 +++
 5 files changed, 2118 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
 create mode 100644 arch/powerpc/configs/gef_sbc610_defconfig
 create mode 100644 arch/powerpc/platforms/86xx/gef_sbc610.c
