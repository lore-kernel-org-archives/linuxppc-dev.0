Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5987DDDF64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:32:48 +1000 (EST)
Subject: Re: [PATCH 8/8] Wrote quirk_mpc8641_transparent() to initialize
	bridge resources.
From: Jon Loeliger <jdl@freescale.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <bfe9571d7d435aa6f52ae8d9ec61a1d5@bga.com>
References: <bfe9571d7d435aa6f52ae8d9ec61a1d5@bga.com>
Content-Type: text/plain
Message-Id: <1180985555.9632.31.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 14:32:35 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 00:55, Milton Miller wrote:

> This is totally unreadable.  include/linux/pci_ids.h exists for a 
> reason,
> please use it.   At least the vendor should be in there.
> 
> If you want to define the device id with the same naming convention
> but in the local source file, I won't object.

> Please use the (new) helper of_read_number in prom.h.

> milton
> 
> PS: how about create instead of wrote in the subject?

All yup.

Thanks,
jdl
