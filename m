Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DEF8DDE37
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 20:44:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l87AimAl001560
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 03:44:49 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87AilIH017097
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 05:44:48 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 0/5] DMA engine driver for Freescale MPC85xx processors.
Date: Fri,  7 Sep 2007 18:53:51 +0800
Message-Id: <11891624353752-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

These patches are DMA engine driver for Freescale MPC85xx processors
which the update for supporting new DMA engine API.

[PATCH 1/5] Add Freescale DMA and DMA channel to Documentation/powerpc/booting-without-of.txt file.
[PATCH 2/5] Add Freescale DMA engine driver maintainer.
[PATCH 3/5] Add DMA of-node to mpc8641hpcn board dts
[PATCH 4/5] Add of-device and DMA bus support to MPC8641HPCN board.
[PATCH 5/5] Add DMA engine driver for Freescale MPC85xx processors.

Best Regards,
Zhang Wei
