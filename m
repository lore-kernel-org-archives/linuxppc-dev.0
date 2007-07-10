Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3AF5DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:36:48 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 0/4] DMA engine driver for Freescale MPC8xxx processor.
Date: Tue, 10 Jul 2007 17:44:20 +0800
Message-Id: <1184060662530-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, All,

These patches are DMA engine driver for Freescale MPC8xxx processor.

They implement the DMA engine API for MEM-2-MEM data DMA transfer
and extend the DMA engine API for IO_ADDR-2-MEM and IO_ADDR-2-IO_ADDR data
transfer.

Patches:
[PATCH 1/4] Add DMA sector to Documentation/powerpc/booting-without-of.txt file.
[PATCH 2/4] Add dma sector to mpc8641hpcn board dts
[PATCH 3/4] Extend the DMA-engine API.
[PATCH 4/4] Add DMA engine driver for Freescale MPC8xxx processors.

Best Regards,
Zhang Wei
