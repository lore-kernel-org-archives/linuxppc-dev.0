Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 57F2E687FB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 03:08:47 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: "David Woodhouse" <dwmw2@infradead.org>
Date: Wed, 23 Nov 2005 17:08:43 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNMEMKCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1132750986.15117.252.camel@baythorne.infradead.org>
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

Hello David,

On Wednesday, November 23, 2005 2:03 PM David Woodhouse wrote:
>> now without drivers/mtd/devices/docprobe.c
>
> Thanks. Are those Intel chips really not CFI-compliant?

I ported this code from the 2.4er Kernel, so I didn´t know
the background, why this code uses the jedec-probe. What
exactly bothers you?

> Please could you also correct each instance of 'MB' to 'MiB'?

OK, i send a new patch.

thanks
Heiko
