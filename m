Return-Path: <dwmw2@infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 511BD681BE
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2005 07:29:54 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: hs@denx.de
In-Reply-To: <AHEILKONAKAEJPHNMOPNIELBCDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNIELBCDAA.hs@denx.de>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 20:29:47 +0000
Message-Id: <1132604987.15117.63.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH]	MTD:	Add support for the PM82x Boards.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-21 at 11:34 +0100, Heiko Schocher wrote:
> Hello,
> 
> the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
> f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds support for
> the NOR flashes and for the DiskOnChip on the PM82X Boards
> from Microsys.

Please use the new DiskOnChip driver in drivers/mtd/nand/ not the old
one.

-- 
dwmw2
