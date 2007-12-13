Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31D00DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 22:40:45 +1100 (EST)
Subject: Re: apm_emulation regression
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1197482587.6558.145.camel@johannes.berg>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BjBf60fkoRVO6/FBFkz8"
Date: Thu, 13 Dec 2007 12:40:19 +0100
Message-Id: <1197546020.6558.247.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BjBf60fkoRVO6/FBFkz8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > That basically means X will break. That's why X broke on the latest
> > ubuntu until I whacked some new scripts in them to force console
> > switching, among other things. Possibly other apps that relied
> > on /dev/apm_bios to be notified of system suspend/resume broke as well.
>=20
> Ah. I guess I never noticed because I had the scripts to do console
> switching all along.

Actually, it just occurred to me that the *kernel* does a console switch
when we use /sys/power/state, so maybe that is why I never had a problem
rather than userspace doing a console switch (which it only started
doing very recently)

johannes

--=-BjBf60fkoRVO6/FBFkz8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2EaIqVg1VMiehFYAQLp5g/8CpRxNqjq5SD+qp/mcHC5nbga/hIRQGRa
AmX84groIYTlh4PyGqg1FyTWHhpjw/ZAMyqQdJkWjrnb6WxiH2uoPFSo6tmx53J7
1npbhtzSBXImO6nkDpTYGzdf2EjfbNYsZUXtWffT79ab5bQh+u/JMcrYERO14ohS
b7QSd3NKphVEZMyVqO01tVYhweC9c4Em1/xdhedCOdWBEh4Kk1+1EZYyu9v16EhE
qIuwAYbIvpjU2WAhjDGsKvE+OhPPoQ4td42eSfl3Z4R0F6Ix30NaCqD9r1NgIm2z
VZ9XdSbTGvxD7WNyIAhcsputzjgzY7VI1ExJ3GK/k2KClwn/OYm/XUhkTYx65O40
WfpRMrVgn/Bxte3iOXOpc+1trdGLgYqE46bGldPKpQzWwPjHKwO3ThgXzt53plNw
aNbxI2S4YksYG2WaDlxWnkODPi+7hfsaLq869hj2KlLp/C3DMkeJuK31MIoUNj+q
Nwp/Rr0ARBAauBTRQ+YfYfYiy2IG97LNSifOxqaGyqBIoH2HXDHWRnTBHN0U7KPp
3WQXxgXde8wSdmpEeJy8Sc420Ws3llBd/XH7coeOIxevYeNwqREeCKWqp04QQmqT
VYahvX6Tt0IbsF9/2aug6uMtnqWZfXT3iQ6k9oZwFAUKD+f2Yh6dx53AiZWA/8cs
CFLfF48WphE=
=dhmp
-----END PGP SIGNATURE-----

--=-BjBf60fkoRVO6/FBFkz8--
