Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 57996B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 00:04:56 +1000 (EST)
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20110406204327.GA11148@iram.es>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 16:04:35 +0200
Message-ID: <1302185075.24704.143.camel@thor.local>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2011-04-06 at 22:43 +0200, Gabriel Paubert wrote:=20
>=20
> The probem is that, at least on one of my machines, the new driver
> does not work: the system hangs (apparently solid, but it's before
> networking starts up and I've not yet hooked up a serial console),=20
> after the "radeon: ib pool ready" message.

Does radeon.agpmode=3D-1 radeon.no_wb=3D1 help?

You might be able to get more information via netconsole if you prevent
the radeon module from loading automatically (or load it with
radeon.modeset=3D0 first) and then load it e.g. via ssh with modeset=3D1.

It would be interesting to see at least all agp/drm/radeon related
kernel messages before the problem occurs.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
