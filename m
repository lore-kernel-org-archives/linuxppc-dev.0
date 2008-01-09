Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56FCFDDF54
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 10:35:16 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/2] Add support for Freescale QUICCEngine UART
Date: Wed,  9 Jan 2008 17:35:04 -0600
Message-Id: <11999217062265-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patchset creates a new serial device driver for the Freescale QE.

Part 1 of this patch set contains all the PowerPC-specific changes.

Part 2 contains all the actual driver and changes for Kconfig and Makefile.

The PowerPC portions of this patchset have already been reviewed and 
approved.  I'd like someone from linux-serial to review the actual driver
itself.
