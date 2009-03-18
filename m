Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7562DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 02:43:20 +1100 (EST)
Date: Wed, 18 Mar 2009 10:43:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 2/2] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318154307.GB3182@loki.buserror.net>
References: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
	<D688018D-6CE0-4627-B813-FC552B1A6E83@kernel.crashing.org>
	<20090318152800.GA29557@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090318152800.GA29557@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 06:28:00PM +0300, Anton Vorontsov wrote:
> It would be great to have #include <gianfar_enet.dts> facility in .dts
> files. ;-) I heard some rumors about this, what was the consequence?..

You can already do a raw include, but in most cases it needs parameterized
templates/macros to make it useful.  There were some patches floating around
for that, but there was some disagreement about syntax and the discussion
seems to have died out.

> [...]
> >> +			ranges;
> >
> > Can this be proper?

It's proper, but a bit lazy. :-)

> > 			ranges = <0x0 0x24520 0x20>;
> 
> Yes, will change.

I'd prefer ranges = <0 0x24000 0x1000>, in case any other sub-blocks come
along in the future.

-Scott
