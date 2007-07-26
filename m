Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3F4FDDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:34:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6Q8YfQ0006826
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 01:34:41 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6Q8YdH5022740
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:34:40 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: galak@kernel.crashing.org, mporter@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 0/5 v3] Porting RapidIO driver from ppc to powerpc
	architecture and adding memory mapped RapidIO driver.
Date: Thu, 26 Jul 2007 16:42:47 +0800
Message-Id: <11854393721520-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches are the version 3 patches for RapidIO with dts update and some minor fixups.

These patches are used for supporting RapidIO controllers of Freescale. I ported them from ppc architecture to powerpc architecture and added some new features, such as memory mapped driver.

[PATCH 1/5] Add the explanation and sample of RapidIO DTS OF-node to the document of booting-without-of.txt file.
[PATCH 2/5] Add RapidIO OF-node to MPC8641HPCN board dts file.
[PATCH 3/5] Add the platform device support with RapidIO to MPC8641HPCN platform.
[PATCH 4/5] Add RapidIO support to powerpc architecture.
[PATCH 5/5] Add the memory management driver to RapidIO.

Please see below descriptions of these patches:
1. Add the RapidIO driver of-device support.
2. Add the RapidIO driver support to MPC8641HPCN board.
3. Port the RapidIO from ppc to powerpc architecture.
4. Add Memory mapped RapidIO driver.
5. Add the support to multi master ports.
6. Add a simple bitmap RapidIO space allocator driver.
7. Change the RapidIO system size of menuconfig to automatically detection.

Thanks!

Best Regards,
Zhang Wei
