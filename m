Return-Path: <patrick@stwcx.xyz>
Received: from sender163-mail.zoho.com (sender1.zohomail.com [74.201.84.157])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2C941A0150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 06:21:36 +1000 (AEST)
Date: Mon, 21 Sep 2015 15:01:19 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Daniel Axtens <dja@axtens.net>
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 skiboot@lists.ozlabs.org
Subject: Re: [Skiboot] Skiboot recovery of MCEs during MMIO read of SCOMs:
 55672ecfa21f
Message-ID: <20150921200119.GD8884@asimov.ibm.com>
References: <1442804568.13852.9.camel@axtens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <1442804568.13852.9.camel@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 01:02:48PM +1000, Daniel Axtens wrote:
> Hi,
>=20
> This relates to 55672ecfa21f ("powerpc/book3s: Recover from MC in
> sapphire on SCOM read via MMIO.").
>=20
> According to that patch, some SCOM reads via MMIO could lead to a
> Machine Check Error in skiboot. That patch provided kernel support for a
> skiboot interface to recover from those MCEs.
>=20
> That patch went into the kernel in Dec 2013. However, modern skiboot
> does not expose the device tree property needed to use this mechanism.
> As far as I can tell, nothing ever went into Skiboot for this purpose.=20
>=20
> Is this something we plan to use in the future? Or is it now redundant?
>=20
> --=20
> Regards,
> Daniel
>=20
> _______________________________________________
> Skiboot mailing list
> Skiboot@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/skiboot

XSCOM does not cause a machine check.  Centaur Inband SCOM does cause a
machine check.  Was this maybe put in place in anticipation of
supporting Inband SCOM?  Does skiboot support Inband SCOM now?

--=20
Patrick Williams

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWAGIPAAoJEKsDR8wtAMEZjcoQAJUzipyT6DDrFhrNhepeJbMe
pXylrLmU4f8cgonNehS2Z3HngpWM7cEiBZ5jsxGfG4iKjgLw8h7rvKkJHosUvTft
KTPCRzOXi3+2NMTtH8/Ok+cc/Q4XQiqTd4KIAgKXxPibIRJiYXdX7Ahu+F76u1Et
41FthoK9PyfuhZtp+4l1AJ/gsbEBnSUlaWI10F9ouge/TFR4/qmoy3cZp1XZ88QJ
DS291I6I83rbuuQr4QxJ7ef4gDrnOBS9jLvF6wmAy2gVvGFk27OEkBu4R0WVsz95
bCoz5f6aSZ+sfZBP/WatBKivRSoXiCJ9gajohMWzUFO7Dk0dpkegjhZRp6Pzvwae
qMii+law+xJIXqWiIbxN0BI85VVDrJvl3QsYgNDcPrdw0GhbyrJEn8ci/IvrSRnw
0EklZ/xKHjSJOPy26QhXClsXX0cr52Z5puAt73IDj6aDsgczg1KWKVxITcnMDSkZ
76g012guluX8KNtttbDGh7S6IM3O2KQR+7lcFZymDj7Wh2stBtJdO8vbTRf7Edrb
ytwK1K5kwcJLSHDe/9Sk3yFdPBqaO8RXofiiDoNVEV0pOybSkx49sdr6gUB5H6ib
f2Ub0KoGH+RIw9lTr5krPJ/DnnGhebZ7lx9Yi0bTNHW2rG2SJdE12YTIPYYjcyCM
Ph1G8d44PwK1DA854DUd
=5taW
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
