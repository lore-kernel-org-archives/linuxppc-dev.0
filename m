Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 7EFE5B6F35
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 02:10:00 +1000 (EST)
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTik154EFPIzMZy5v-Mj6mhWt-hCaFYvLPi5oLWFD@mail.gmail.com>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
	<1279030767.515.15.camel@thor.local>
	<AANLkTilk4-gIiJPQb5aqZ5v4YvgzsddexnsmrFBER5HO@mail.gmail.com>
	<1279033177.515.16.camel@thor.local>
	<AANLkTik154EFPIzMZy5v-Mj6mhWt-hCaFYvLPi5oLWFD@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 18:09:56 +0200
Message-ID: <1279037396.515.19.camel@thor.local>
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

On Die, 2010-07-13 at 18:02 +0200, jjDaNiMoTh wrote:=20
> 2010/7/13 Michel D=C3=A4nzer <michel@daenzer.net>:
> > What does the log file contain with modeset=3D1?
>=20
> We have no message, after the X.org freeze.
>=20
> messages.log:
> [...]
> Jul 13 17:11:01 jim kernel: [drm] Num pipes: 1
> Jul 13 17:13:39 jim kernel: Using PowerMac machine description
>=20
> (we have rebooted)
>=20
> In Xorg.0.log there aren't information after the crash, only a right star=
tup.

Are you looking at the right log file, not the one from the new X server
after the reboot?

Maybe you could post the full dmesg, Xorg.0.log and X server stderr
output (should be captured in the gdm/kdm log file) from trying with
modeset=3D1.


> At this time, I think it isn't a kernel problem, am I right?

With modeset=3D1 it most likely is a kernel (configuration) problem.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
