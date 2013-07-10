Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 454B72C013D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 12:23:22 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so6154755pbc.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jul 2013 19:23:19 -0700 (PDT)
Date: Wed, 10 Jul 2013 10:23:07 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/math-emu: remove the dead code in math.c
Message-ID: <20130710022307.GB361@pek-khao-d1.corp.ad.wrs.com>
References: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
 <1373420623-24869-2-git-send-email-haokexin@gmail.com>
 <20130710020132.GA7491@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
In-Reply-To: <20130710020132.GA7491@concordia>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 12:01:33PM +1000, Michael Ellerman wrote:
> On Wed, Jul 10, 2013 at 09:43:42AM +0800, Kevin Hao wrote:
> > The math.c is only built when CONFIG_MATH_EMULATION is enabled.
> > So we would never get into the case that CONFIG_MATH_EMULATION
> > is not defined in this file.
>=20
> Any idea why we have that there? ie. have the config symbols changed
> over time or was this always dead code?

No idea. I tried to trace this before submitting the patch. But it has
been there since the begin of the git history. So I just assume that it is
always dead code. :-)

Thanks,
Kevin

>=20
> cheers

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR3MWLAAoJEJNY7TDerrFxktgH+wdgGZ7Pd3N2FYQPtv16bEVp
tSw1QnY+uD7Gtrao8+C9uGqyLGU+QdviEcqF98YpnXkXEn6e76CMWUtl9IODKKKH
Ucf+0AwtvGzBkODZWHhTxFU9clN1SUek4DFNE9Xjv7o5BnEIPtNc+1OAjSiSSPsq
/JFlttfxAHam+XvTxnQzHlkBXgIpBPc81V+boD4P0wQkiF7qwcQMQTGlYOIPA0+l
ImLV1OCJnjcW9A0LiqDokKGlFe5Pb6EuIlchD2PLe1LNbKcxtMEsp93eJd7a3I56
cpC4ZHC9h/RYXBzugMtQdB7VeBC6VAMQg+GsLrJhSHODBzG1le9U7FjWpG7BCJs=
=umHa
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
