Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05121A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:32:39 +1000 (AEST)
Date: Wed, 15 Apr 2015 17:05:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 06/31] vfio: powerpc/spapr: Disable DMA
 mappings on disabled container
Message-ID: <20150415070522.GH25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
In-Reply-To: <1428647473-11738-7-git-send-email-aik@ozlabs.ru>
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


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:48PM +1000, Alexey Kardashevskiy wrote:
> At the moment DMA map/unmap requests are handled irrespective to
> the container's state. This allows the user space to pin memory which
> it might not be allowed to pin.
>=20
> This adds checks to MAP/UNMAP that the container is enabled, otherwise
> -EPERM is returned.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLg2yAAoJEGw4ysog2bOSICAP/Rm9GJF64O5HhTRD7z1U4rSr
ocVysRxT3xRhll8hNYCtZkHXMvT6dKn96l7S+m8Uy31vfPn32Kf96Kv1iflB7zpf
2xksyuZD6NwKUdtEJ+226lw4tfYGvM0j9U9d5SwB6CyZIzVrJgW2Ty6uHgWsXUK4
JiHN1BsRTlXemNl8KUvX+ac/prHcqyfxzly5ROEWvyLLa5eKAYUJ7kgp1fQVavsk
eXXyLkWitzZ926mIG+l1AAmdXAb6HUHXuBCvQLz9QWTEusqKlimSPAYUee/Miwu1
9YIXtfQf8hlOlMNduw5eOymBi2vIyMssU9vO6NI8BFH8YurBmteiPltjpFwoI1DO
8xqvCu0ojjsIoY+2ZbxlbZIu8IlUD9nIKNqr5HPe4YfpNE1TxYgHqIQivQEctujw
diJlvm4EgXEpGd3+WtIhJcTf0Hbz5NCIz1gA8QNYk58EBiGARPyySyZ4Krvzqaei
quWSk3sJM5ubz2P/2HCfLug352goCUiGyCJC2Qewatq5YmCBNs+nN4iGojpupNhC
LdZAG2FFQex+mngkTqu7cG1lEe8EvOEx/d26acXBCJn7A75tS2V5mdWJECHAyTyt
xLtwfwGPvQQTIOMKvXxxeSELSbt8az9Fq/OeKMtODmegq9DNGbhYKal1UKf7ea7L
vkq9ZnkdJirLppe14Yov
=GR+i
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--
