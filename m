Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 33EB7DDFF1
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 22:25:35 +1000 (EST)
Date: Mon, 26 May 2008 16:25:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFC PATCH 1/2] mmc_spi: export probe and remove functions
Message-ID: <20080526122533.GA9595@polina.dev.rtsoft.ru>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<20080523182834.GA469@polina.dev.rtsoft.ru>
	<20080526141836.72db0623@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080526141836.72db0623@mjolnir.drzeus.cx>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 26, 2008 at 02:18:36PM +0200, Pierre Ossman wrote:
> On Fri, 23 May 2008 22:28:34 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > ...so we'll able to write bindings for the OpenFirmware without
> > messing with #ifdefs in the driver itself.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> This looks extremely wrong. Encapsulating probe functions isn't exactly
> in line with the device model and bound to confuse people.
> 
> Your patches doesn't give a complete picture of the OF side of things,
> but can't you solve this by having an init callback somewhere?

Easily, I think this is good (better) idea. Will do.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
