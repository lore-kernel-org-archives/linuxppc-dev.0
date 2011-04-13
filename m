Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 581B2B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 18:02:11 +1000 (EST)
Date: Wed, 13 Apr 2011 10:02:04 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
Message-ID: <20110413080204.GA3871@iram.es>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1302608770.27054.36.camel@thor.local>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2011 at 01:46:10PM +0200, Michel Dänzer wrote:
> BTW, if your kernel contains commit
> 69a07f0b117a40fcc1a479358d8e1f41793617f2, can you try if reverting that
> helps?

My kernel is pristine 2.6.38 and does not include this commit
(was introduced before 2.6.39-rc1 according to gitk).

	Gabriel
