Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Jul 2013 14:42:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] of: Feed entire flattened device tree into the random pool
Message-ID: <20130725044234.GI6806@voom.fritz.box>
References: <20130725125122.78accf44@kryten> <20130725031717.GB15673@concordia>
 <20130725143031.16af0a96@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
In-Reply-To: <20130725143031.16af0a96@kryten>
Cc: devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2013 at 02:30:31PM +1000, Anton Blanchard wrote:
>=20
> Hi Michael,
>=20
> > But why not put the initcall in drivers/of/fdt.c, that way it's not
> > early but it's still common ?
>=20
> Good idea! How does this look? So long as it happens before
> module_init(rand_initialize) we should be good.

This must be some strange new meaning of the word "random" of which I
was not previously aware.  But I guess it's marginally better than
nothing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iEYEARECAAYFAlHwrLoACgkQaILKxv3ab8YdSACeKo/ceJ1WkLo3FlDg9wN/Ayza
1zQAnAynlR5xJs+CnvhoUuoLeuYkcS2h
=VU3b
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
