Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC8BBDDF2E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:22:45 +1000 (EST)
Date: Wed, 4 Apr 2007 17:25:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404172514.5ae95e60@the-village.bc.nu>
In-Reply-To: <4613CF6A.2090407@zytor.com>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404122154.GF31973@thunk.org> <4613CF6A.2090407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dwmw2@infradead.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> One option would be to move the 8250-based serial ports, to, say, 
> /dev/ttyN* (for National Semiconductors -- the best I could come up 
> with) and redefine /dev/ttyS* as a serial port multiplexer which maps in 
> all the types, for the ones that really want dynamic mapping.

I think this makes it worse than simply starting the 8250 ports at a
platform specific minor offset.

Alan
