Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87557DDFB8
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 23:08:52 +1000 (EST)
Date: Mon, 7 Jul 2008 23:08:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: kbuild tree build failure
Message-Id: <20080707230843.ec0b4efb.sfr@canb.auug.org.au>
In-Reply-To: <20080707125138.GA16569@uranus.ravnborg.org>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<20080707125138.GA16569@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_23_08_43_+1000_ixfaJZ=WcnuFfbzh"
Cc: linuxppc-dev@ozlabs.org, Paul, linux-next@vger.kernel.org,
	Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_23_08_43_+1000_ixfaJZ=WcnuFfbzh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Mon, 7 Jul 2008 14:51:38 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
>
> I see what is wrong - we use a int to hold the value above
> and it does not fit.
>=20
> Will fix tonight or tomorrow.

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_23_08_43_+1000_ixfaJZ=WcnuFfbzh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyFVsACgkQjjKRsyhoI8yXewCfWft6NI3GMjZdcbc9wrMzMgbx
pQgAoICmDMvt6308gBtrNHuiB4/9b8R2
=7IP2
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_23_08_43_+1000_ixfaJZ=WcnuFfbzh--
