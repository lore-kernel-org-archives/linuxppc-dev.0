Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 632D8DE03C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 18:13:28 +1100 (EST)
Date: Thu, 10 Jan 2008 18:13:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3] [POWERPC] Add common clock setting routine
	mpc52xx_psc_set_clkdiv()
Message-Id: <20080110181316.1213f273.sfr@canb.auug.org.au>
In-Reply-To: <20080110052629.8853.52821.stgit@trillian.secretlab.ca>
References: <20080110052629.8853.52821.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jan_2008_18_13_16_+1100_OuAHt/ZSHGT5g=eH"
Cc: linuxppc-dev@ozlabs.org, dragos.carp@toptica.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jan_2008_18_13_16_+1100_OuAHt/ZSHGT5g=eH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Wed, 09 Jan 2008 22:26:30 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +mpc52xx_map_common_devices(void)
>  {

> +	/* Clock Distribution Module, used by PSC clock setting function */
> +	np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);

What happens if we find no node?

> +	mpc52xx_cdm =3D of_iomap(np, 0);
> +	of_node_put(np);
>  }

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jan_2008_18_13_16_+1100_OuAHt/ZSHGT5g=eH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhcWQTgG2atn1QN8RAmBmAJoCTNFlpRj5uY28dz5r6f0i5ezAMgCfQlLK
JHpLNkESi5Ie3oDV8lER+P0=
=oAqZ
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jan_2008_18_13_16_+1100_OuAHt/ZSHGT5g=eH--
