Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74436DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 12:16:32 +1000 (EST)
Date: Tue, 22 Jul 2008 02:58:50 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-ID: <20080722025850.0d073a5e@lxorguk.ukuu.org.uk>
In-Reply-To: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
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

On Tue, 22 Jul 2008 10:25:20 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Linus, Alan,
> 
> Today's linux-next (actually just Linus' tree) build (powerpc
> ppc64_defconfig) failed like this:

Yes I know.

I've been trying to get the other patches merged but each of the five
pulls of Linus tree I have done has broken the tty patch merges *AGAIN*
so I still don't have them tested and ready to merge despite it being 3AM.

So much for the linux-next tree. Please give it until tomorrow or you are
just going to break the tree again and mean I have to run another set of
tests and regressions.

Alan
