Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09C881A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 23:03:20 +1100 (AEDT)
Date: Wed, 18 Mar 2015 12:03:10 +0000
From: Mark Brown <broonie@kernel.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Message-ID: <20150318120310.GH2869@sirena.org.uk>
References: <20150226161142.D08681A2360@localhost.localdomain>
 <20150303184403.GE21293@sirena.org.uk> <54F6BBA7.8040008@c-s.fr>
 <20150306114413.GM21293@sirena.org.uk> <550137C5.1020109@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
In-Reply-To: <550137C5.1020109@c-s.fr>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 07:52:53AM +0100, leroy christophe wrote:
> Le 06/03/2015 12:44, Mark Brown a =E9crit :

> >It's legacy, all that code is really old.  Modern code is written in as
> >architecture and firmware neutral a fashion as possible to make things
> >more consistent and maintainable.

> This patch is only a small bug fix.
> That driver already contains calls to of_iomap() and other related of_
> functions.
> Is it worth rewriting the driver for just a small bug fix ?

I don't think you need to fix other usages but I'd rather not introduce
new usages of legacy APIs that just need to be fixed up.

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCWl+AAoJECTWi3JdVIfQfZsH/0fCYhhOEQLFPasU8BgvaLBP
xrfFRNI70rtnduJIRrUQZyYToXK3K63n2s3h3irKb7w80/id7d93fEv/NATIqQ/I
/8I7HuuV59ojtpMEKQISVxXAokxwOZhERQWPCpHFRAYndLgUD/r20Oo/kY0quj/m
39ka5bhDK16jCbfUSpyCNmKJ2Xt0vqIeE9lhGepnkoDjCFd/JMvYXj0zPrPcAbsx
SEk6rjwDwd3cX3Qq895Lt4bTfpExJRckqpstF2a9hRNG7EIKeisgSuNGZzSt49Y9
kqCLK6ai+Qvx2p/a78Q11eEnnih02VRVCZ5WnSZ361jUCMaozJrYI8Zk8q3VWWw=
=dop1
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
