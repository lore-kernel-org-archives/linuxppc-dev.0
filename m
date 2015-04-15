Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D8C1A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:10:09 +1000 (AEST)
Date: Wed, 15 Apr 2015 14:00:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 02/31] vfio: powerpc/spapr: Do cleanup when
 releasing the group
Message-ID: <20150415040037.GD25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
In-Reply-To: <1428647473-11738-3-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:44PM +1000, Alexey Kardashevskiy wrote:
> This clears the TCE table when a container is being closed as this is
> a good thing to leave the table clean before passing the ownership
> back to the host kernel.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLeJlAAoJEGw4ysog2bOS9iIP/iomxArwyT2EVTW2TNvu5lTc
qYGWc4fbRg0fezT4pmTgcsQvhZrFZEqC+e7rRBDlwCk1HvWMeejuv5CPa+q8RaXh
NXTHD9S4/WS707NOqCvHdRxhoEx/V65CjNAtt1v9jt0I68smRbseDHZGVJOSacb9
ObjtmYMEu2OlPpHCDPEFZ2cJzI1HzF/C8N83/1DxWvQTa4Th1Y/JDu2G3UTrLsar
ET2Z5ftsL2RQtu4l5oPAC7i2xjKQz9HO/fht9UZc+IlBiAaCQbGmsjJB49GS3ald
1+wHNpQOIQwij16+paaLdzfarIt6oz2FwI+qyf/4rSdlCHtFkQGccPodeUa122V/
sSwfm0zPU0sFyagEWnQoQAP8JjxDmkFEIJyxeAnv7M0MQMb/qEhxtlj7PdJa+EjD
ZlDdv2Ebg/cloc5CNWtj6E+b1so0bGcgN3Cyd9cqE4rcZ5DaOWfLnuW4hms627kG
q2IZ2/iS3Nt59Wq9EFBylFo+/wDPGa81VuvftlexR/Vib4Oxld8RK7fdco1ZYVoj
aaN7Cv7eJk0Am2i0gwY6p7Zqk45PUCIv728Lk1SfQjw7HtOPDh/IyuW8SXie8bUu
6zCYtfS3WFaLejXSV5GL0kTga5ibsjSkazvcMYjG7qjBJ+IjihSVli3sUOd8d9zT
rH6RrdNgZfFGQXwHpcTH
=3zEa
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
