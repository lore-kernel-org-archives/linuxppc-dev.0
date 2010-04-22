Return-Path: <Sylvain.Lamontagne@novariant.com>
Received: from sm1.novariant.com (sm1.novariant.com [76.238.142.74])
	by ozlabs.org (Postfix) with ESMTP id 38735B7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 06:34:28 +1000 (EST)
Subject: Re: Boot hang when setting console=none with MPC5200B custom board
From: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <h2ofa686aa41004221211w227bfcc4l3c7a6cc26a81e7dc@mail.gmail.com>
References: <1271962721.12334.34.camel@slamon-laptop.novariant.com>
	<h2ofa686aa41004221211w227bfcc4l3c7a6cc26a81e7dc@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Apr 2010 16:34:26 -0400
Message-ID: <1271968466.12334.52.camel@slamon-laptop.novariant.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[snip]=20
> Can you halt the processor with JTAG and look at the contents of __log_bu=
f?
Ok I'll try that as soon as I can get CodeWarrior to work again...

> > 1. Is it possible ?
>=20
> Yes, I believe so, but I haven't tried.
Ok=20
>=20
> > 2. Do you have any idea how it can be achieve ?
>=20
> You should be doing the right thing.  Are your userspace init scripts
> trying to start a getty on the non-existent console device?
>=20
Nope and using init=3D/bin/sh=20
gave me /bin/sh: can't access tty; job control turned off
And then=20
/ # tty
not a tty

Is helpful ? This is while using console=3DttyS1,115200 (so when I know
it's working)

> > 3. Do you know a bug in 2.6.29.2 that could prevent this to work ?
>=20
> no
Ok :)=20
>=20
> > 4. The 'chosen' node is empty in my dts, does it require something to b=
e
> > set ?
>=20
> no
Good to know=20
>=20
> I think your best bet is to figure out some way to get at __log_buf to
> retrieve the kernel output after the failed boot.
Ok I'll try to revive CodeWarrior (I would better appreciate a BDI2000,
but I'm stuck with a Freescale USB TAP that require CodeWarrior)

>=20
> Cheers,
> g.
>=20
Thank you

Sylvain
