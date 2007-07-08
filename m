Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 29D3EDDEED
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 06:48:19 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Sun, 8 Jul 2007 22:36:36 +0200
References: <1179245829.8132.100.camel@rhino> <468FDB8F.4050007@ru.mvista.com>
	<3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
In-Reply-To: <3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707082236.36722.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 08 July 2007, Segher Boessenkool wrote:
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A08042@60 {
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device_type =3D "8042";
> >
> >> Drop the device_type. =A0A number as a name isn't
> >> all that great, either.
> >
> > =A0 Yet it's kinda accepted years ago, see:
> >
> > http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt
>=20
> That's not a published recommendation or anything like that.
>=20

But still, it's what got used in what appears to be all ISA based machines
with such a keyboard controller, both PowerPC and i386 ones.

Are you suggesting that we should declare all existing machines wrong and do
our own thing instead?

	Arnd <><
