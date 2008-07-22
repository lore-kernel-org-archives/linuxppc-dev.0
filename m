Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9454EDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 21:02:40 +1000 (EST)
Date: Tue, 22 Jul 2008 11:44:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-ID: <20080722114436.2c13edea@lxorguk.ukuu.org.uk>
In-Reply-To: <20080722130152.f115224d.sfr@canb.auug.org.au>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722025850.0d073a5e@lxorguk.ukuu.org.uk>
	<20080722130152.f115224d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What is your problem with the linux-next tree.  The problem was
> discovered and reported when I first merged the ttydev tree into
> linux-next on July 1.  The fixes were in linux-next on July 2.

Yes .. and ? The clashes kept happening despite that when I was doing the
merges (and going on holiday for a week and trying to sort it out with
limited time and internet access)

Sorry I don't follow your line of discussion at all here ?

> > just going to break the tree again and mean I have to run another set of
> > tests and regressions.
> 
> Please give what until tomorrow?

it - the situation. The patches have all gone to Linus.

Alan
