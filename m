Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 3BE08B6F4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 19:02:55 +1000 (EST)
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: kevin diggs <diggskevin38@gmail.com>
Date: Thu, 14 Apr 2011 11:02:36 +0200
In-Reply-To: <BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop> <1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
	<1302736869.28876.91.camel@pasglop>
	<BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1302771756.15520.100.camel@thor.local>
Mime-Version: 1.0
Cc: Mikael Pettersson <mikpe@it.uu.se>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2011-04-13 at 18:43 -0500, kevin diggs wrote:=20
>=20
> On Wed, Apr 13, 2011 at 6:21 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2011-04-13 at 12:52 -0500, kevin diggs wrote:
> >> > Actually I do get a crash in X later on... something in the radeon
> >> DRM
> >> > interrupt code is getting what looks like a NULL dereference. I'll
> >> try
> >> > to dig that one later on. I don't know if it's related to your
> >> problem
> >> > at all though.
> >> >
> >> In this context, what does 'crash' mean? The X thingy goes down? Or
> >> the whole OS?
> >
> > Depends, with xmon enabled you get into xmon :-) Dunno if the oops is
> > fatal but it could be.
> >
> > Cheers,
> > Ben.
> >
> >
>=20
> As I think I have the same hardware as you (7,3, radeon 9600) If you
> can tell me how to reproduce it maybe I can poke around a little.
> Thus, at least temporarily, freeing you up for other stuff.
>=20
> I kinda need a break from fighting with GCC.

FWIW, the problem Ben refers to might be fixed in current mainline by
commit d87dfdbfc91c5e37288e7e8f7afdd992ba61a60d which reverts
69a07f0b117a40fcc1a479358d8e1f41793617f2 .


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
