Return-Path: <SRS0+b54f8ebc752649c30a08+822+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 574FF687D0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 00:03:14 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: hs@denx.de
In-Reply-To: <AHEILKONAKAEJPHNMOPNCEMHCDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNCEMHCDAA.hs@denx.de>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 13:03:06 +0000
Message-Id: <1132750986.15117.252.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-mtd@lists.infradead.org
Subject: Re: [PATCH]	MTD:	Add support for the PM82x Boards.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-23 at 13:37 +0100, Heiko Schocher wrote:
> now without drivers/mtd/devices/docprobe.c

Thanks. Are those Intel chips really not CFI-compliant? 
Please could you also correct each instance of 'MB' to 'MiB'?

-- 
dwmw2
