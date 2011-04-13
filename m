Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 4FE8AB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 20:01:59 +1000 (EST)
Date: Wed, 13 Apr 2011 12:01:51 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
Message-ID: <20110413100151.GA3066@iram.es>
References: <20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local>
	<20110412120055.GA7995@iram.es>
	<1302629362.15520.25.camel@thor.local>
	<20110413075943.GA27996@iram.es>
	<1302682573.28876.78.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302682573.28876.78.camel@pasglop>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2011 at 06:16:13PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2011-04-13 at 09:59 +0200, Gabriel Paubert wrote:
> > 
> > Well, X is dead, or rather in an infinite ioctl loop as described
> > above.
> > IIRC, the display enters a power-down mode and there is nothing to
> > see.
> 
> So basically the card crashed. There's about an infinite amount of
> reasons why radeons do so, sometimes it has to do with them not liking
> what you ate that day...
> 
> The only thing I can see that could be of use would be a bisect

Bisecting for something which I have never got to work (radeon with
KMS) on this machine is something I don't know how to do...

Note that radeon without KMS also always ends up crashing, but it
may take hours. The only case where the machine works reliably is 
when glxinfo claims that it is using software rendering.
 
	Regards,
	Gabriel
