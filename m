Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 21 Jun 2006 14:32:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kelly Daly <kelly@au1.ibm.com>
Subject: Re: [PATCH] powerpc: disable OProfile for iSeries (take 2!)
Message-Id: <20060621143236.14bc4e1e.sfr@canb.auug.org.au>
In-Reply-To: <200606211352.55446.kelly@au.ibm.com>
References: <200606211151.01386.kelly@au.ibm.com>
	<1150859433.8293.9.camel@localhost.localdomain>
	<200606211352.55446.kelly@au.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Jun_2006_14_32_36_+1000_06lMnq/599vQR=KX"
Cc: linuxppc64-dev@ozlabs.org, kelly@au1.ibm.com, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Jun_2006_14_32_36_+1000_06lMnq/599vQR=KX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jun 2006 13:52:55 +1000 Kelly Daly <kelly@au1.ibm.com> wrote:
>
> This patch removes the changes from an earlier patch that disables
> oProfile for iSeries within the oProfile KConfig (submitted Feb 23,
> 2006).  Checks within the arch init for iSeries, still allowing profiling
> for timer interrupts (using firmware_has_feature).
>=20
> Signed-off-by: Kelly Daly <kelly@au.ibm.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Jun_2006_14_32_36_+1000_06lMnq/599vQR=KX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEmMvkFdBgD/zoJvwRAmUEAJ9z45YxPmxeL5Z5g2hsTpetwcOhOQCgmEmH
z7K5KAj/uzR16PKHxlWuwb0=
=i5oi
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Jun_2006_14_32_36_+1000_06lMnq/599vQR=KX--
