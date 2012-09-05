Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AC522C0815
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 19:24:03 +1000 (EST)
Message-ID: <1346837023.2257.57.camel@pasglop>
Subject: Re: [PATCH 13/25] macintosh/mediabay: add a const qualifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 05 Sep 2012 19:23:43 +1000
In-Reply-To: <20120905080249.GI28643@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop> <20120905080249.GI28643@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-05 at 10:02 +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Sep 05, 2012 at 12:40:17PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-König wrote:
> > > This prepares *of_device_id.data becoming const. Without this change
> > > the following warning would occur:
> > > 
> > > 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> > > 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > 
> > Ack all of these assuming you test built (I didn't).
> "all" means the two mediabay patches? And yes, they are all built
> tested.

Yeah, anything powerpc you had in your series, but the two mediabay ones
are what I spotted when digging through stuff today :-)

> >                                                      Do you need me to
> > carry any of this via the powerpc tree ?
> The patch that adds the const to of_device_id depends[1] on this patch.
> And the other mediabay is only valid after that const is added. So the
> easiest is if the series is pulled in one go. Arnd intended to let Linus
> pull it for 3.6-rc1 but it was missed because of a communication
> problem. So I intend to get it in during the 3.7 merge window.

Ok, I'm happy for Arnd to carry all of these, I trust his
judgement/review for that stuff including for ppc specific bits.

Cheers,
Ben.

> Best regards
> Uwe
> 
> [1] it's only a soft depend, because the result is "only" a warning, but
> still.
> 
