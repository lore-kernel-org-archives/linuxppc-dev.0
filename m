Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id EC5B4B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 01:01:37 +1000 (EST)
Message-ID: <1334761280.5989.332.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 18 Apr 2012 17:01:20 +0200
In-Reply-To: <m27gxd9jie.fsf@igel.home>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <m24nshb7l9.fsf@igel.home> <1334756287.5989.326.camel@thor.local>
 <m2bomp9krb.fsf@igel.home> <1334759498.5989.328.camel@thor.local>
 <m27gxd9jie.fsf@igel.home>
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

On Mit, 2012-04-18 at 16:55 +0200, Andreas Schwab wrote:=20
> Michel D=C3=A4nzer <michel@daenzer.net> writes:
>=20
> > On Mit, 2012-04-18 at 16:28 +0200, Andreas Schwab wrote:=20
> >> Michel D=C3=A4nzer <michel@daenzer.net> writes:
> >>=20
> >> > Have you tried smaller aperture sizes (uninorth_agp.aperture) and/or
> >> > radeon.test=3D1? (See commit 52f072cb084bbb460d3a4ae09f0b6efc3e7e8a8=
c)
> >>=20
> >> Neither changes anything.
> >
> > How small aperture sizes have you tried?
>=20
> 32M. With the old UMS driver 3D once worked fine ...

That doesn't necessarily mean much per se, as with UMS memory is only
statically mapped into the AGP GART once (so most of those 32M are
wasted at least most of the time), whereas with KMS it's dynamically
(un)mapped on demand.


> > The purpose of radeon.test=3D1 isn't to change anything but to catch
> > problems transferring data between system memory bound via AGP GART and
> > video RAM. Does it pass for the whole AGP aperture?
>=20
> AFAICT yes.  For the default 256M it printed "[drm] Tested GTT->VRAM and
> VRAM->GTT copy for GTT offset" for every other offset from 0x201000
> to 0xfe01000.

Okay, so apparently there's at least no obvious problem with 256M on
your UniNorth revision either.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
