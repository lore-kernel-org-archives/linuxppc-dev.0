Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AD925DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 21:20:19 +1100 (EST)
Date: Tue, 4 Mar 2008 21:20:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 06/17] Change the kernel configurated RapidIO system
	size to auto-probing.
Message-Id: <20080304212012.9ea2d3b5.sfr@canb.auug.org.au>
In-Reply-To: <1204648202-5495-6-git-send-email-wei.zhang@freescale.com>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-2-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-3-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-4-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-5-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-6-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__4_Mar_2008_21_20_12_+1100_lcnUNoje9gdeyq90"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Mar_2008_21_20_12_+1100_lcnUNoje9gdeyq90
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Mar 2008 00:29:51 +0800 Zhang Wei <wei.zhang@freescale.com> wrot=
e:
>
> +	if (!(rionet_active =3D (struct rio_dev **)__get_free_pages(GFP_KERNEL,
> +				mport->sys_size ? __ilog2(sizeof(void *)) + 4
> +				: 0))) {

Please separate the assignment from the test.

> +		if (!(rswitch->route_table =3D kzalloc(sizeof(u8)*
> +					RIO_MAX_ROUTE_ENTRIES(port->sys_size),
> +					GFP_KERNEL))) {

Again.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__4_Mar_2008_21_20_12_+1100_lcnUNoje9gdeyq90
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzSJjTgG2atn1QN8RAh0CAJ49UjbcwrxRmhDK6R6+teCUKLzYsACfQclf
ZDGIjwK8GnOfgT19A1MUgZU=
=47pJ
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Mar_2008_21_20_12_+1100_lcnUNoje9gdeyq90--
