Return-Path: <me@twolife.org>
Received: from smtp2.mail.be.easynet.net (smtp2.mail.be.easynet.net
	[212.100.160.76])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C17B67A64
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 03:06:49 +1000 (EST)
Date: Tue, 29 Mar 2005 18:34:22 +0200
From: Sebastien NOEL <me@twolife.org>
To: debian-powerpc@lists.debian.org
Message-Id: <20050329183422.5c0e08ef.me@twolife.org>
In-Reply-To: <1112066934.6809.4.camel@gaston>
References: <1112066934.6809.4.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_Mar_2005_18_34_22_+0200_BTpv3PrBYMnWGU5J"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] sleep & cpufreq problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__29_Mar_2005_18_34_22_+0200_BTpv3PrBYMnWGU5J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Mar 2005 13:28:54 +1000 , Benjamin Herrenschmidt wrote:

> Hi !
>=20
> Here are a couple of patches against current linus bk (one was already
> posted to this list) that should fix a number issues related to sleep
> and wakeup, especially in conjunction with cpufreq transitions.
>=20
> Please test and let me know if it fixes a problem you had, it adds a new
> problem, or it has no effect, stuff still doesn't work (if it used to
> work and still work, no need to bug me).
>=20
> Thanks !
>=20
> Patches are at:
>=20
> http://gate.crashing.org/~benh/ppc32-pmac-sleep-fix.diff
> http://gate.crashing.org/~benh/ppc32-cpufreq-gpio-off.diff
>=20
> Thanks,
> Ben.
>=20

Hi Ben !

I apply your 3 patches on 2.6.12-rc1 and my ibook g4 doesn't crash anymore
after wakeup when i change the cpu speed.

My gratitude is far bigger than my english vocabulary, thank you very much!


Sebastien

--Signature=_Tue__29_Mar_2005_18_34_22_+0200_BTpv3PrBYMnWGU5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCSYOWo1pObvABdcoRAtxFAKCfy69qLIQGm1cqvycFzPOSnuyB3QCfeyYG
PlDc/kLjlqw8HZNt7qf62Cs=
=D3we
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Mar_2005_18_34_22_+0200_BTpv3PrBYMnWGU5J--
