Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5567DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 17:16:12 +1000 (EST)
Date: Wed, 3 Oct 2007 17:15:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Message-Id: <20071003171551.7184d83b.sfr@canb.auug.org.au>
In-Reply-To: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
References: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Oct_2007_17_15_51_+1000_NxS974y+zyQDxyCg"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Oct_2007_17_15_51_+1000_NxS974y+zyQDxyCg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Oct 2007 16:27:26 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Stephen Rothwell (5):
>       [POWERPC] Create and use CONFIG_WORD_SIZE
>       [POWERPC] Remove debug printk from vio_bus_init
>       [POWERPC] Simplify vio_bus_init a little for legacy iSeries
>       [POWERPC] Make vio_bus_type static
>       [POWERPC] Limit range of __init_ref_ok somewhat

Would you also consider:

[POWERPC] Prepare to remove of_platform_driver name
(http://patchwork.ozlabs.org/linuxppc/patch?id=3D13667)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Oct_2007_17_15_51_+1000_NxS974y+zyQDxyCg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHA0GvTgG2atn1QN8RAsylAJ4sb7f8o791Gf2YOxbDn8YfmupnmwCgk9OU
NpdV8VntI0W+PeaNT1ZAzfg=
=NgGX
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Oct_2007_17_15_51_+1000_NxS974y+zyQDxyCg--
