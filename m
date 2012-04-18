Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id DDB21B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 23:03:01 +1000 (EST)
Message-ID: <1334754160.5989.305.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 18 Apr 2012 15:02:40 +0200
In-Reply-To: <m28vhtb7tc.fsf@igel.home>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2ty0hbi4j.fsf@igel.home> <1334735555.5989.272.camel@thor.local>
 <m28vhtb7tc.fsf@igel.home>
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

On Mit, 2012-04-18 at 13:25 +0200, Andreas Schwab wrote:=20
> Michel D=C3=A4nzer <michel@daenzer.net> writes:
>=20
> > On Mit, 2012-04-18 at 09:42 +0200, Andreas Schwab wrote:=20
> >> Michel D=C3=A4nzer <michel@daenzer.net> writes:
> >>=20
> >> > Not sure it's a good idea to set both of these =3Dy: It will prevent=
 the
> >> > radeon driver from initializing at all by default if radeonfb is act=
ive.
> >>=20
> >> You can say video=3Dradeonfb:off.
> >
> > I know, I'm referring to the default behaviour without any relevant
> > kernel command line options.
>=20
> Which is exactly the right behaviour for me.

You do understand that 'prevent the radeon driver from initializing at
all' means direct rendering won't work at all, even with older Mesa
drivers?


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
