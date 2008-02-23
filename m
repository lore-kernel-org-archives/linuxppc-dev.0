Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2E12DDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 20:51:20 +1100 (EST)
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080223092458.GA6873@10.1.86.20>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
	<20080223092458.GA6873@10.1.86.20>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FRHUeP1OkVCiVfHCAoFR"
Date: Sat, 23 Feb 2008 10:51:08 +0100
Message-Id: <1203760269.13162.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FRHUeP1OkVCiVfHCAoFR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> My first trial used ARCH=3Dppc and caused this infinity of "SPE used in k=
ernel"
> messages, but I then recompiled linux with ARCH=3Dpowerpc.  With the mess=
age
> not ifdef'ed out, this second kernel does not emit "SPE used in kernel"
> messages,

If I were to venture a guess I'd point to the fact that the arch/powerpc
Makefile contains

# No SPE instruction when building kernel
KBUILD_CFLAGS +=3D $(call cc-option,-mno-spe) =20

while the arch/ppc one doesn't.

johannes

--=-FRHUeP1OkVCiVfHCAoFR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR7/si6Vg1VMiehFYAQLfyBAArsY5LaT7bG1BuxFqP+8XHAOhABGPAiQu
MPnjoLvqFN7xXkHu+zBpsm5BqSIk7JoNeE7eyDFn5LnSD5jxm3Q41HQ0lAcWbhrh
mHiiW4HCZhZEMfRI6srDC1h6gtwGhB7HRZhRoMHTVlkNaGfrD+ArhH897o5JaPpI
N5J/R6Zr1JYL9dh4HVy44jcJWGiQiIyT7L0fJqETmjnW3sWjjAIw+LPOHVRNQkBQ
80W/th2D+woGNezo2SMIY0PYpJ2y8gUMGTDW6W+mRb+k1gJVX69f0Bzhsf4yFQmU
Zog852klRWR7CMNuAZp/xtxNiRjWxD9ZqmKpCeJnLv649Q9uRkcwQFVAhxxTo0Zg
gitykp0M+FKKFwmVhID1HfS11Ro086bWuNVkmG6MSLiW+9xFfAa6Z6O//d0uydnN
8Rd6xqJd96n7BLEGHxFdNho2fpdqquFuUYQ20CCLOmon/ZY5uTtY8xfnYBl/R/cJ
OaOctaeSHsdWY2c+tpeNFm0fjK89+/dG7dRaQzdIkG2KZ47N+KKRqM98TLK4KqIS
4hzaidFV0BwRIpQZXps+bxjY6nxYDKzmQ+dcvL5lV+r5vL189rhUsoiStQZJUtCk
CihNZfhci/HkdZwkvA9TxOE46pMzb8Qo1ANGrIKGt72mLVN8MootTY/aHLzq7VgF
epm2gr5o5Pw=
=TeCI
-----END PGP SIGNATURE-----

--=-FRHUeP1OkVCiVfHCAoFR--
