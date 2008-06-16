Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 33D16DDFB5
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 23:23:33 +1000 (EST)
Date: Mon, 16 Jun 2008 17:23:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
Message-ID: <20080616132330.GA7468@polina.dev.rtsoft.ru>
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
	<20080614175723.209e93dc@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080614175723.209e93dc@mjolnir.drzeus.cx>
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

On Sat, Jun 14, 2008 at 05:57:23PM +0200, Pierre Ossman wrote:
> On Thu, 5 Jun 2008 20:16:24 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > Here is v3. I'm out of ideas if you won't like it. :-)
> > 
> > v3:
> > - Now these bindings are using bus notifiers chain, thus we adhere to the
> >   spi bus.
> > 
> 
> Now this was nice and clean. I take it Grant doesn't like this version
> though. What's the downside of it?

To me the main downside of it is inability to make this modular. :-/

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
