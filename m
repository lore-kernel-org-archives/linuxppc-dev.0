Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B6F9DDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 22:02:59 +1000 (EST)
Date: Wed, 4 Jun 2008 12:47:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080604124714.55dbce65@core>
In-Reply-To: <alpine.LFD.1.10.0806031932370.3473@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806041205.45833.nickpiggin@yahoo.com.au>
	<alpine.LFD.1.10.0806031932370.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Benjamin, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-arch@vger.kernel.org, scottwood@freescale.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anyway, Intel certainly seems to document that WC memory is serialized by=
=20
> any access to UC memory.

I don't believe that is actually true on Pentium Pro at least.

>   So what started out as a "we can do accesses to the frame buffer more=20
>   efficiently without anybody ever even having to know or care" has=20
>   turned into a whole nightmare of people using it for other things, and=
=20
>   then you very much _do_ have to care! ]

Notably graphics where 3Dfx lined the registers up specifically to make
this work. We were also using it with I=C2=B2O where it gave a small
performance gain.

Alan
