Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9BA8CDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 11:56:17 +1100 (EST)
Date: Wed, 9 Jan 2008 11:55:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 4/7] [POWERPC] Xilinx: Add correct compatible list for
	device tree bus bindings.
Message-Id: <20080109115559.f959f4b0.sfr@canb.auug.org.au>
In-Reply-To: <20080108193519.A7B6E160806C@mail15-blu.bigfish.com>
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080108193519.A7B6E160806C@mail15-blu.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_11_55_59_+1100_Hzg_ts1pC7rBOGNk"
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_11_55_59_+1100_Hzg_ts1pC7rBOGNk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue,  8 Jan 2008 11:35:06 -0800 Stephen Neuendorffer <stephen.neuendorff=
er@xilinx.com> wrote:
>
> +static struct of_device_id xilinx_of_bus_ids[] =3D {

Should be __initdata.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_11_55_59_+1100_Hzg_ts1pC7rBOGNk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhBukTgG2atn1QN8RAqylAKCZmlVAwSVTEhGT0fYVrt0hGJRnNACfblUD
/mhn2nF5Bb3D9iglgynSV0o=
=5ZVx
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_11_55_59_+1100_Hzg_ts1pC7rBOGNk--
