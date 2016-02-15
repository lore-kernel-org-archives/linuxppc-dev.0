Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC8151A0D0B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:21:28 +1100 (AEDT)
Date: Mon, 15 Feb 2016 14:47:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 1/7] powerpc: Make vmalloc_to_phys() public
Message-ID: <20160215034729.GT2732@voom.fritz.box>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GMArzDD+OGn24EFp"
In-Reply-To: <1455501309-47200-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GMArzDD+OGn24EFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 12:55:03PM +1100, Alexey Kardashevskiy wrote:
> This makes vmalloc_to_phys() public as there will be another user
> (KVM in-kernel VFIO acceleration) for it soon. As this new user
> can be compiled as a module, this exports the symbol.
>=20
> As a little optimization, this changes the helper to call
> vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
> struct page may not be power-of-two aligned which will make gcc use
> multiply instructions instead of shifts.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GMArzDD+OGn24EFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwUpRAAoJEGw4ysog2bOSW+4P/Redo+8asEu4MuKaERJpTsci
WNEtpSPAt+goZG0LMFl2t4kksen/428qtBNA0UsRNaXzGr+SZR1oBiJ5b47xVh/R
5r+5WQJVtGAxc92DAXJ+vGewRP8L923o5s2FO0w1jRQJbfFi6KPvxCB5kE2fcrKn
rRXOZbmS0JwqqvHjeOnF9+uX8syvL2//qHdOpIkR57tKTzgLszU3QPc9F3/ZT2At
aYxc/IeUf9qBTiiKVZwP+SFf1HTPFlmybSOjzdDWFqvp/BoRrR0zvEBh4BkbIkTV
+gU6UnhR8qPrTB+f/kFqx7c+2Ab1XJ3Zx3ftEqYTOvbTObqvtHhmYLdbZltq7vtB
UDXDhfwx3salvD0Fer3nUaD4dkGxwKQslENk5pzCz1uLKGno1CDHowdN9zi4yts7
J4OXQY7bod8RN8VMuhbLEL8q/1FW/rRv8jqJ9+CBS8xrav6YSmZo6wwbfbz0cUMY
7C018NXdhqcKLx8Q5CarIru4mIF+d1Bdns4J28g/9c7eQbjeuwAJyB2I4iwQ+5lJ
vA5WXfE19GNqo6X26Y8lNFTKLtzO2Nufw9EnqHKfx7J5zXm161VfKhTnGAxYVoa0
X8P5TVVYNiHbHlHE8eHn7Nee+AipRngGyt7qFQtVuEjhnyopU8TzbQh848uOwYXc
bGp9L5rBoFoaxz0jfUs+
=zaZK
-----END PGP SIGNATURE-----

--GMArzDD+OGn24EFp--
