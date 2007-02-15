Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3AE9DE056
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:14:27 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1FHEOvd005327
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:14:24 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1FHEOeJ474534
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:14:24 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1FHEHr1006365
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:14:20 -0700
Date: Thu, 15 Feb 2007 11:14:14 -0600
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Message-ID: <20070215171414.GU923@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702151141.49708.jens@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 11:41:49AM +0100, Jens Osterkamp wrote:
> On Thursday 15 February 2007, Benjamin Herrenschmidt wrote:
> > > I'm totally confused about who the heck is the spidernet maintainer.
> > 
> > Me too :-)
> > 
> > It's been a bit of a mess. I suggest we get our gear together (Linas,
> > Jens, Kou) and provide you a single patch set from a single source in
> > the upcoming couple of days coming from the designated maintainer.

OK.

However, I think the blast of paches is a statistical anomoly,
I'm expecting future activity on spidernet to drop to just about zero.

> > Jens ? Linas ? Is that ok with you guys ? Who gets to be that
> > maintainer ?
>
> Linas has done a pretty good job on improving the driver in the last half
> year or so and he also has access to all the necessary hardware so I think
> he would be the right person for the job.

It seems I've been nominated twice. Since I'm expecting future activity
to drop to zero, how hard can this be? :-)

I can send a tested patch series (merging all three sources)
immediately, assuming you like the tree these would be based on. 
Any special instructions or proceedures to follow, any secret
initiation rites, hazing, or change of citizenship required?

--linas
