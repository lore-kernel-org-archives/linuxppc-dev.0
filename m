Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8D2F6B7105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 22:48:26 +1100 (EST)
Message-ID: <4E9D677A.3030706@pengutronix.de>
Date: Tue, 18 Oct 2011 13:48:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
 (freescale p1010)
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
 <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
 <20111018094328.GC22814@sgi.com>
 <D79CB818-C14E-4C8D-9A8D-42B39ADE20B2@kernel.crashing.org>
In-Reply-To: <D79CB818-C14E-4C8D-9A8D-42B39ADE20B2@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig33C0CCED0BB1A65EAAE88C6E"
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
 linux-can@vger.kernel.org, socketcan-core@lists.berlios.de,
 Robin Holt <holt@sgi.com>, PPC list <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33C0CCED0BB1A65EAAE88C6E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/18/2011 01:43 PM, Kumar Gala wrote:
> Thanks, I'll look into this internally at FSL.  I think its confusing
> as hell to have "fsl,p1010-flexcan" in an ARM .dts and don't think
> any reasonable ARM customer of FSL would know to put a PPC SOC name
> in their .dts.  I'll ask the HW guys what's going on so we can come
> up with a bit more generic name so we don't have to constantly change
> this.  Even if its just:
>=20
> fsl,ppc-flexcan & fsl,arm-flexcan.

If you talk the HW guys ask them for a name for the coldfire flexcan
core, too please ;)

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig33C0CCED0BB1A65EAAE88C6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6dZ3oACgkQjTAFq1RaXHM+EwCgmUMAlsrgCK7Kmoj/ONoZIDzY
/ocAnif9NwNKeyUhrLITqIHu+gJoxOq/
=5Hv0
-----END PGP SIGNATURE-----

--------------enig33C0CCED0BB1A65EAAE88C6E--
