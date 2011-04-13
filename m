Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8E73B6F4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 22:17:11 +1000 (EST)
Date: Wed, 13 Apr 2011 14:17:00 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: small git lesson [Was: Re: Revert
	737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?]
Message-ID: <20110413121700.GQ18850@pengutronix.de>
References: <20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local>
	<20110413080204.GA3871@iram.es>
	<20110413081246.GK18850__3180.67204575545$1302682420$gmane$org@pengutronix.de>
	<m339lm8r31.fsf@redhat.com> <20110413103144.GB3066@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110413103144.GB3066@iram.es>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Andreas Schwab <schwab@redhat.com>, Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Gabriel
On Wed, Apr 13, 2011 at 12:31:44PM +0200, Gabriel Paubert wrote:
> On Wed, Apr 13, 2011 at 10:59:14AM +0200, Andreas Schwab wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > 
> > > $ git name-rev --refs=refs/tags/v2.6\* 69a07f0b117a40fcc1a479358d8e1f41793617f2
> > > 69a07f0b117a40fcc1a479358d8e1f41793617f2 tags/v2.6.39-rc2~3^2~43^2~4
> > >
> > > so it was introduced just before -rc2.
> > 
> > $ git tag --contains 69a07f0b117a40fcc1a479358d8e1f41793617f2
> > v2.6.39-rc1
> > v2.6.39-rc2
> > 
> 
> So who is right? I think it was before rc1. 
Yep, correct. I interpreted the output of git name-rev to mean it's not
included in a tag earlier than v2.6.39-rc2, but actually that's wrong.
It's just that it's easier (for some definition of easy) to reach the
commit in question from v2.6.39-rc2 than from v2.6.39-rc1.

> However in this case the main reason to fire gitk was to have a quick look 
> at the patch and its context, and simply reported the "Precedes" line 
> in the display, which is 2.6.39-rc1. It also follow v2.6.37-rc2, which means
> that it has been quite a long time outside the main tree.
I think this conclusion isn't valid in general. (E.g. in git itself a
bug-fix is often done on top of the commit that introduced it and than
merged into master. Still the bugfix might be new.) But looking at the
AuthorDate of 69a07f0b117a seems to support your statement.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
