Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E82F1DDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 06:11:48 +1100 (EST)
Subject: Re: [linux-pm] [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20070214144556.GC25910@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<20070214144556.GC25910@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TRf2EKv4GHGAT4HlgM1I"
Date: Wed, 14 Feb 2007 20:11:36 +0100
Message-Id: <1171480296.6093.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TRf2EKv4GHGAT4HlgM1I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-14 at 15:45 +0100, Pavel Machek wrote:

> Can you disable timer interrupt on the interrupt controller, instead?

No, it's not actually an external interrupt, the "timer interrupt" on
powerpc is the decrementer exception which is built into the CPU.

In any case, the soft-irq disable stuff I already posted a bit later
provides the same with no more runtime overhead than we already have.

johannes

--=-TRf2EKv4GHGAT4HlgM1I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF017o/ETPhpq3jKURAjt9AKC1L3dZDIYIaue8Os66b7nx4dTa2gCeInjI
p63Mh9pQwNrbH4YKP5+oFpM=
=Ztey
-----END PGP SIGNATURE-----

--=-TRf2EKv4GHGAT4HlgM1I--
