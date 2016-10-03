Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-qt0-x234.google.com (mail-qt0-x234.google.com
 [IPv6:2607:f8b0:400d:c0d::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sngnB2lKzzDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 23:08:45 +1100 (AEDT)
Received: by mail-qt0-x234.google.com with SMTP id 38so78185900qte.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 05:08:45 -0700 (PDT)
Date: Mon, 3 Oct 2016 09:08:35 -0300
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Anton Blanchard <anton@samba.org>, linux-crypto@vger.kernel.org,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 George Wilson <gcwilson@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/3] Fix crypto/vmx/p8_ghash memory corruption
Message-ID: <20161003120835.GA10133@gallifrey>
References: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
 <20160929065908.653ec5c2@kryten>
 <20161002144047.GG18268@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <20161002144047.GG18268@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you.

--=20
Regards,
Marcelo

On Sun, Oct 02, 2016 at 10:40:47PM +0800, Herbert Xu wrote:
> On Thu, Sep 29, 2016 at 06:59:08AM +1000, Anton Blanchard wrote:
> > Hi Marcelo
> >=20
> > > This series fixes the memory corruption found by Jan Stancek in
> > > 4.8-rc7. The problem however also affects previous versions of the
> > > driver.
> >=20
> > If it affects previous versions, please add the lines in the sign off to
> > get it into the stable kernels.
>=20
> I have added them to patches 1 and 2.  Thanks.
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJX8kpDAAoJEM8aS8c01e1HzKIH/2KZ33BTs6CedA1TllgLIy0u
go9pOUEObPuC7QRsYLePQhO+zT5qKc4Jp+XIj4JefWaSaMbhuPfCe8SqdCt37IzF
p8tR295srt2C2Wj6g78emq3zmOtF7ILUTsbyXgsOcIemtyzcrOOJk5ZDJBRXwwqr
kUGRIqKZb3BF6+lKC95xguEzNQRW+hOhmADQ5Wy46cjnsnEr0RqyJyJDE2c/c6OM
G0j/zrplPYQfgfa6gbe4uTK243Wi4FZAd8pgsoWEo1Zbj3I7reUScb3SjBqGtuEi
JjvB40AeY9faY38OEkN2njYuOB0fSC5RUxex/i5XHJBpzYHhl18fKa0yNgj5Qns=
=h4R7
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
