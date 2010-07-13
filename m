Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id B34FAB6EF1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 03:23:03 +1000 (EST)
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTikR0HRoBawbUJyS_cEkhEu9Sj6q8hR2F0v6CLDK@mail.gmail.com>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
	<1279030767.515.15.camel@thor.local>
	<AANLkTilk4-gIiJPQb5aqZ5v4YvgzsddexnsmrFBER5HO@mail.gmail.com>
	<1279033177.515.16.camel@thor.local>
	<AANLkTik154EFPIzMZy5v-Mj6mhWt-hCaFYvLPi5oLWFD@mail.gmail.com>
	<1279037396.515.19.camel@thor.local>
	<AANLkTikR0HRoBawbUJyS_cEkhEu9Sj6q8hR2F0v6CLDK@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 19:22:58 +0200
Message-ID: <1279041778.515.22.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, xorg-driver-ati@lists.x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Die, 2010-07-13 at 19:05 +0200, jjDaNiMoTh wrote:=20
>=20
> So, I've now the acceleration. The main problem was radeon.agpmode,
> setting it to -1 (and removing all files in xorg.conf.d related to
> radeon) fixes all issue (also the freeze on glxgears). Now I have
> ~1500 FPS, and I'm fine with it (before I got 100 FPS).
>=20
> I get the acceleration also with a non-KMS capable kernel, so I think
> we got the point. I will add the option to modprobe.conf for archPPC.

Note that e.g. on my PowerBook agpmode=3D1 works (mostly) stable, and if
AGP works it performs significantly better than PCI.


> I tried a program which use a lot opengl, the only thing I see is
> ERROR: GL error 1282
> ERROR: Ignoring 1 openGL errors

Something the app does causes Mesa to raise a GL_INVALID_OPERATION
error. This may be a bug in the app or in Mesa.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
