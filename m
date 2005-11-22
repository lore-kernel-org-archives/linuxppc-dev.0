Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6B26D687D4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2005 17:19:08 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: "David Woodhouse" <dwmw2@infradead.org>
Date: Tue, 22 Nov 2005 07:18:51 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNKEMACDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1132604987.15117.63.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: RE: [PATCH]	MTD:	Add support for the PM82x Boards.
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Monday, November 21, 2005 9:30 PM David Woodhouse wrote:
>> the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
>> f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds support for
>> the NOR flashes and for the DiskOnChip on the PM82X Boards
>> from Microsys.
> 
> Please use the new DiskOnChip driver in drivers/mtd/nand/ not the old
> one.

I use the new driver.
I made the changes in drivers/mtd/devices/docprobe.c,  because I
ported it from the 2.4 Kernel. Should I delete this and resubmit
the patch?

thanks
Heiko
