Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 2 Apr 2008 23:30:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 1/4] [POWERPC] Initialize paca->current earlier
Message-Id: <20080402233008.43dd2e10.sfr@canb.auug.org.au>
In-Reply-To: <20080402075253.8726ADDEDD@ozlabs.org>
References: <1207122728.672673.111194574046.qpush@grosgo>
	<20080402075253.8726ADDEDD@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__2_Apr_2008_23_30_08_+1100_2ELgX5WpvvOqAOez"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__2_Apr_2008_23_30_08_+1100_2ELgX5WpvvOqAOez
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Apr 2008 18:52:09 +1100 Benjamin Herrenschmidt <benh@ozlabs.org>=
 wrote:
>
> This changes it so that all PACAs are statically initialized with
> __current pointing to the init task. For non-0 CPUs, this is fixed
> up before use.

You might want to see how this impacts on Tony Breed's 1024 way patches.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__2_Apr_2008_23_30_08_+1100_2ELgX5WpvvOqAOez
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH83xUTgG2atn1QN8RAh6XAKCIWtXMks3C2WK0DtUeLEg6P3wxxwCfdcNk
lFRM9VkKw+GwPqNK/NEhMbg=
=a+1N
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Apr_2008_23_30_08_+1100_2ELgX5WpvvOqAOez--
