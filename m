Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96583DE08D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:19:54 +1100 (EST)
Date: Mon, 29 Oct 2007 23:17:38 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Add device-tree aware NDFC driver
Message-ID: <20071029201738.GA2022@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a device-tree aware PowerPC 44x NanD Flash Controller driver
The code is based on the original NDFC driver by Thomas Gleixner, but
since it's been changed much and has initialization/clean-up completely
reworked it's been put into a separate ndfc_of.c file. This version
supports both separate mtd devices on each chip attached to NDFC banks and
single mtd device spread across identical chips (not using mtdconcat) as well.
The choice is selected with device tree settings. This has been tested
on PowerPC 440EPx Sequoia board.
Any comments are greatly appreciated.
Thanks,
Valentine.
