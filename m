Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E3A5DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:40:46 +1100 (EST)
Date: Wed, 12 Dec 2007 10:40:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071212164035.GB4329@loki.buserror.net>
References: <20071210204705.GA31263@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:47:05PM +0300, Anton Vorontsov wrote:
> 5 - FSL UPM infrastructure:
> ---------------------------
> UPM address register is shared among UPMs, so we have to do
> proper locking. On the other hand, if we know that specific
> board using only one UPM we could bypass locking, and gain some
> performance win.

Not enough to be worth the complexity compared to the overhead of NAND
access -- especially in the likely case of a non-SMP build.

-Scott
