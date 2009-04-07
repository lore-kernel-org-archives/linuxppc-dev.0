Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8CDD5DDF9D
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:50:25 +1000 (EST)
Date: Tue, 7 Apr 2009 17:50:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Message-Id: <20090407175018.8bd24370.sfr@canb.auug.org.au>
In-Reply-To: <alpine.LRH.2.00.0904070941140.17130@vixen.sonytel.be>
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
	<20090407022743.GA12174@lixom.net>
	<alpine.LRH.2.00.0904070941140.17130@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__7_Apr_2009_17_50_18_+1000_qlI=UqqO/g391yKo"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__7_Apr_2009_17_50_18_+1000_qlI=UqqO/g391yKo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Apr 2009 09:41:38 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterho=
even@sonycom.com> wrote:
>
> On Mon, 6 Apr 2009, Olof Johansson wrote:
> >=20
> > This is really only beneficial if various people build for powerpc often
> > enough. If major subsystem maintainers aren't going to hit the errors
> > it's more of a hinderance for PPC than a global benefit, right?
>=20
> Will be built nightly: http://kisskb.ellerman.id.au/kisskb/matrix/

And I build it several (i.e. between 20 and 80) times a day :-( (after
merging it with all sorts of stuff this is upcoming).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__7_Apr_2009_17_50_18_+1000_qlI=UqqO/g391yKo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbBboACgkQjjKRsyhoI8yIUACfcwMsldJ4A7fDYeJ04l+d80O7
4g0An2aQSPEMmaTMBVHDnW2oDtv+vP4H
=tmm6
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Apr_2009_17_50_18_+1000_qlI=UqqO/g391yKo--
