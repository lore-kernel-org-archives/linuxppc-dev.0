Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32E2DB7BD4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:46:37 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 228D3DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:46:37 +1000 (EST)
Date: Fri, 21 Aug 2009 15:46:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] powerpc/pci: Remove dead checks for CONFIG_PPC_OF
Message-Id: <20090821154630.e796bc4f.sfr@canb.auug.org.au>
In-Reply-To: <20090821053005.2289.59853.stgit@localhost.localdomain>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053005.2289.59853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Aug_2009_15_46_30_+1000_/5lB03vkco5ZHotH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Aug_2009_15_46_30_+1000_/5lB03vkco5ZHotH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, 20 Aug 2009 23:30:09 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> PPC_OF is always selected for arch/powerpc.  This patch removes the stale
> #defines
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Good work.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Aug_2009_15_46_30_+1000_/5lB03vkco5ZHotH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqONLYACgkQjjKRsyhoI8yilgCfT4CJkoKjpz53FAcYfg2oLqqr
v+YAniwHG5EpAOLTIDk11jJZCLYLMxaO
=Msvb
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Aug_2009_15_46_30_+1000_/5lB03vkco5ZHotH--
