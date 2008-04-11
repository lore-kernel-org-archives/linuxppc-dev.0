Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 71441DE024
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:34:53 +1000 (EST)
Date: Fri, 11 Apr 2008 09:34:50 +0200
From: Sven Luther <sven@genesi-usa.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: State of the MPC5200 PSC AC97 driver
Message-ID: <20080411073450.GA1818@powerlinux.fr>
References: <47FDEF9B.5000506@semihalf.com> <47FE3160.2060907@genesi-usa.com>
	<20080411065100.GQ13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080411065100.GQ13814@pengutronix.de>
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-dev@ozlabs.org,
	spitzauer_77@gmx.de, sven@genesi-usa.com,
	Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 08:51:00AM +0200, Robert Schwebel wrote:
> Hi Matt,
> 
> On Thu, Apr 10, 2008 at 04:25:20PM +0100, Matt Sealey wrote:
> > I have a copy of the driver I hacked to work with the new PSC
> > framework but it doesn't "work" anymore - I have no idea why.
> >
> > Mail me privately if you want it, I have no time to make patches or
> > look for a good reason for the breakages, but it compiles at least.
> > The Efika hack should be gone now (irrelevant since we released a
> > firmware that obseletes it) and the other fixmes should be by the
> > wayside considering the fscking thing doesn't play sound anymore...
> 
> I'd be interested as well; do I read your mail right that you have
> already managed to hear sound coming out of the MPC5200B PSC AC97
> interface? You would be the first one I've heared of, so it would
> definitely be interesting to see your code. 

Indeed, sound was known to work on the efika plateform, altough it is
the last patch which not merged upstream, and needs some work.

I leave matt send it to you, as he has been more in touch with this
lately.

Friendly,

Sven Luther
