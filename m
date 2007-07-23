Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4E3FDDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 04:39:17 +1000 (EST)
Date: Mon, 23 Jul 2007 13:35:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Kmalloc returns which address
Message-ID: <20070723183510.GA29223@ld0162-tx32.am.freescale.net>
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
	<469B92DC.50609@freescale.com> <11737504.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11737504.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jul 22, 2007 at 08:47:47PM -0700, Misbah khan wrote:
> yes really it would really generate a machine check... but i guess if you
> convert this virt address to physical address using __pa() then pass it to
> the ioremap() i guess things will work .

What would be the point?  All you'd get is another virtual mapping.

Is the DMA mapping API that difficult?

-Scott
