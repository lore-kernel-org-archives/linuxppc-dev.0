Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0FCCEDDED4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 15:03:48 +1100 (EST)
Date: Tue, 8 Jan 2008 15:03:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 6/8] pseries: phyp dump: debugging print routines.
Message-Id: <20080108150336.21337772.sfr@canb.auug.org.au>
In-Reply-To: <4782C53D.4060506@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C53D.4060506@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_15_03_36_+1100_tRth/PYicTFHW=zu"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_15_03_36_+1100_tRth/PYicTFHW=zu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

Just a trivial comment.

On Mon, 07 Jan 2008 18:35:09 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
> +	printk(KERN_INFO "dump disk section =3D %d\n",ph->dump_disk_section);

Please put a space after the ','.  Here and later.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_15_03_36_+1100_tRth/PYicTFHW=zu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgvYbTgG2atn1QN8RAsJ/AJ9wO8c2408P1pscKlWFYk3KIxu3fQCfUafM
tL2otWhHIOf577oFDQzZh/s=
=vgLC
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_15_03_36_+1100_tRth/PYicTFHW=zu--
