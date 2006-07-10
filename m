Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A9BD67B61
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 00:46:30 +1000 (EST)
Subject: Re: Linux v2.6.18-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
	<1152537672.28828.4.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 15:40:13 +0100
Message-Id: <1152542413.27368.131.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Steve Fox <drfickle@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ar Llu, 2006-07-10 am 08:21 -0500, ysgrifennodd Will Schmidt:
> On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > > We've got a ppc64 machine that won't boot with this due to an IDE error.
> > 
> > What machine precisely ?
> 
> I see a slightly more verbose version on a JS20 blade. 
> 
> hda: dma_timer_expiry: dma status == 0x24
> hda: DMA interrupt recovery
> hda: lost interrupt

That in repeat generally means the IRQ logic on the platform has been
broken. If we don't get interrupts we don't work very well.

Also check if booting with "nodma" set on the relevant ide interface
makes a difference. Just to be sure. If it does then submit patches to
fix the bug.

Alan
