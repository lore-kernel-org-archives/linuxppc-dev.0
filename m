Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 91D24B6FF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 23:38:25 +1000 (EST)
Message-ID: <1334756287.5989.326.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 18 Apr 2012 15:38:07 +0200
In-Reply-To: <m24nshb7l9.fsf@igel.home>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <m24nshb7l9.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 13:30 +0200, Andreas Schwab wrote:=20
> Michel D=C3=A4nzer <michel@daenzer.net> writes:
> > On Mit, 2012-04-18 at 09:54 +0200, Andreas Schwab wrote:=20
> >> Michel D=C3=A4nzer <michel@daenzer.net> writes:
>=20
> This was a test with agpmode=3D1:
>=20
> Linux agpgart interface v0.103
> agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
> agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
> agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0

Have you tried smaller aperture sizes (uninorth_agp.aperture) and/or
radeon.test=3D1? (See commit 52f072cb084bbb460d3a4ae09f0b6efc3e7e8a8c)


> >> After that is is dead.
>=20
> > The whole machine?
>=20
> No pings any more.

You might be able to get more information via netconsole. That's how I
tracked down and fixed one cause of MCEs during the GPU reset.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
