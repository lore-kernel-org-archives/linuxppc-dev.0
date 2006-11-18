Return-Path: <schmitz@mail.biophys.uni-duesseldorf.de>
Received: from opal.biophys.uni-duesseldorf.de
	(opal.biophys.uni-duesseldorf.de [134.99.176.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.biophys.uni-duesseldorf.de",
	Issuer "mail.biophys.uni-duesseldorf.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BE13067B5F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 21:47:59 +1100 (EST)
Date: Sat, 18 Nov 2006 11:34:41 +0100 (CET)
From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118000235.GV31879@stusta.de>
Message-ID: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
References: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sammy@sammy.net, linux-m68k@vger.kernel.org,
	James Simmons <jsimmons@infradead.org>,
	linux-fbdev-devel@lists.sourceforge.net, sun3-list@redhat.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	geert@linux-m68k.org, adaplas@pol.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 18 Nov 2006, Adrian Bunk wrote:

> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
>
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI

FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
the final one soonish.

	Michael
