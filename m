Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 6AD481007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 03:29:40 +1000 (EST)
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gabriel Paubert <paubert@iram.es>
Date: Tue, 12 Apr 2011 19:29:22 +0200
In-Reply-To: <20110412120055.GA7995@iram.es>
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es> <1302608770.27054.36.camel@thor.local>
	<20110412120055.GA7995@iram.es>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1302629362.15520.25.camel@thor.local>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Die, 2011-04-12 at 14:00 +0200, Gabriel Paubert wrote:
> On Tue, Apr 12, 2011 at 01:46:10PM +0200, Michel D=C3=A4nzer wrote:
> > >=20
> > > With no_wb=3D1 the driver goes a bit further but the X server ends
> > > up in an infinite ioctl loop and the logs are:=20
> >=20
> > Which ioctl does it loop on? Please provide the Xorg.0.log file as well=
.
>=20
> From memory, the code was 0x64, which is DRM_RADEON_GEM_WAIT_IDLE.

Note that it's normal for this ioctl to be called every time before the
GPU accessible pixmap memory is accessed by the CPU. Unless the ioctl
always returns an error, this may not indicate a problem on its own.=20


> The Xorg.0.log from the previous boot is attached.

I don't see any obvious problems in it. Can you describe the symptoms of
the problem you're having with X a bit more?

One thing I notice is that the X server/driver are rather oldish. Maybe
you can try newer versions from testing, sid or even experimental to see
if that makes any difference.=20


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
