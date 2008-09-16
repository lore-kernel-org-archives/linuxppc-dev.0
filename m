Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-8.online-age.net (ext-nj2ut-8.online-age.net
	[64.14.54.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 88AE0DE035
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 19:57:32 +1000 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8G9vRav025204
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 05:57:27 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8G9vQgt000639
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 05:57:26 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v5 0/2] powerpc: Board support for GE Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Tue, 16 Sep 2008 10:57:42 +0100
Message-ID: <20080916095741.9992.96106.stgit@ubuntu8041.localdomain>
In-Reply-To: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
References: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
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

 arch/powerpc/boot/dts/gef_sbc610.dts     |  260 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig      |    9 +
 arch/powerpc/platforms/86xx/Makefile     |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c |  149 +++++++++++++++++
 4 files changed, 418 insertions(+), 1 deletions(-)
