Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3115BDDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 18:06:14 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l71869JT014340
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 01:06:09 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l718671J021205
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 03:06:08 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 0/2] Use common quirks routines for ULI chips
Date: Wed,  1 Aug 2007 16:14:26 +0800
Message-Id: <11859560681182-git-send-email-wei.zhang@freescale.com>
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

These two patches add common quirks routines for 
ULI chip on MPC8641HPCN and MPC8544DS board.
It supposes to support future powerpc platform using ULI chips.

[PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC architecture with ULI chip quirk functions.
[PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and MPC8544DS boards.

Best Regards,
Zhang Wei
