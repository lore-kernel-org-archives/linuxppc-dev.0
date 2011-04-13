Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46BC9B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 18:12:59 +1000 (EST)
Date: Wed, 13 Apr 2011 10:12:46 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: small git lesson [Was: Re: Revert
	737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?]
Message-ID: <20110413081246.GK18850@pengutronix.de>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local>
	<20110413080204.GA3871@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110413080204.GA3871@iram.es>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2011 at 10:02:04AM +0200, Gabriel Paubert wrote:
> On Tue, Apr 12, 2011 at 01:46:10PM +0200, Michel Dänzer wrote:
> > BTW, if your kernel contains commit
> > 69a07f0b117a40fcc1a479358d8e1f41793617f2, can you try if reverting that
> > helps?
> 
> My kernel is pristine 2.6.38 and does not include this commit
> (was introduced before 2.6.39-rc1 according to gitk).
gitk is not the best tool to find this out.

$ git name-rev --refs=refs/tags/v2.6\* 69a07f0b117a40fcc1a479358d8e1f41793617f2
69a07f0b117a40fcc1a479358d8e1f41793617f2 tags/v2.6.39-rc2~3^2~43^2~4

so it was introduced just before -rc2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
