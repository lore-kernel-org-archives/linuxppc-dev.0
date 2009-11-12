Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E7B2B7B79
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 21:51:01 +1100 (EST)
Date: Thu, 12 Nov 2009 21:50:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: rr tree build failure
Message-Id: <20091112215055.25405fc3.sfr@canb.auug.org.au>
In-Reply-To: <1258016520.2140.329.camel@pasglop>
References: <20091112190308.443d97a3.sfr@canb.auug.org.au>
	<1258016520.2140.329.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__12_Nov_2009_21_50_55_+1100_GusNWkD_jNf+rZcx"
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@samba.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__12_Nov_2009_21_50_55_+1100_GusNWkD_jNf+rZcx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 12 Nov 2009 20:02:00 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Thanks. Our EXPORTs are bogus (probably leftovers) it seems. I'll dbl
> check tomorrow but that looks like a patch I should pickup in powerpc
> -next anyways.

That was the idea, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__12_Nov_2009_21_50_55_+1100_GusNWkD_jNf+rZcx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr76I8ACgkQjjKRsyhoI8yvAQCeOBxfl9MaJNSiimwVyVoNMYdM
ZcwAoJcuKSpgUOQ0f34B+12Bh6R5Kyuz
=/e+g
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Nov_2009_21_50_55_+1100_GusNWkD_jNf+rZcx--
