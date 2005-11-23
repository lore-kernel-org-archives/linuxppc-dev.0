Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (213-239-205-147.clients.your-server.de
	[213.239.205.147]) by ozlabs.org (Postfix) with ESMTP id 4199468734
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 21:57:27 +1100 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: hs@denx.de
In-Reply-To: <AHEILKONAKAEJPHNMOPNKEMACDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNKEMACDAA.hs@denx.de>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 11:39:24 +0100
Message-Id: <1132742364.32542.122.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org
Subject: RE: [PATCH]	MTD:	Add support for the PM82x Boards.
Reply-To: tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-22 at 07:18 +0100, Heiko Schocher wrote:
> > Please use the new DiskOnChip driver in drivers/mtd/nand/ not the old
> > one.
> 
> I use the new driver.
> I made the changes in drivers/mtd/devices/docprobe.c,  because I
> ported it from the 2.4 Kernel. Should I delete this and resubmit
> the patch?

Yes, please.

	tglx
