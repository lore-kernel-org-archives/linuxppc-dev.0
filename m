Return-Path: <wei.zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B77CFDE20D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 18:55:44 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org
Subject: [PATCH 0/5] Porting RapidIO driver from ppc to powerpc architecture
	and adding memory mapped RapidIO driver.
Date: Tue, 12 Jun 2007 17:02:15 +0800
Message-Id: <11816389393593-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Matt Porter,

These patches are used for supporting RapidIO controllers of Freescale. I ported them from ppc architecture to powerpc architecture and added some new features, such as memory mapped driver.

[PATCH 1/5] Add the explanation and sample of RapidIO DTS sector to the document of booting-without-of.txt file.
[PATCH 2/5] Add RapidIO sector to MPC8641HPCN board dts file.
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
