Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFAF11A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 15:11:23 +1000 (AEST)
Date: Tue, 21 Jul 2015 15:11:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Fix calculation for memory
 allocated for TCE table
Message-ID: <20150721051128.GL19189@voom.fritz.box>
References: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KSn4sQg3MnruwCB4"
In-Reply-To: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KSn4sQg3MnruwCB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 08:45:51PM +1000, Alexey Kardashevskiy wrote:
> The existing code stores the amount of memory allocated for a TCE table.
> At the moment it uses @offset which is a virtual offset in the TCE table
> which is only correct for a one level tables and it does not include
> memory allocated for intermediate levels. When multilevel TCE table is
> requested, WARN_ON in tce_iommu_create_table() prints a warning.
>=20
> This adds an additional counter to pnv_pci_ioda2_table_do_alloc_pages()
> to count actually allocated memory.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KSn4sQg3MnruwCB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrdSAAAoJEGw4ysog2bOSn+sP/3th3GIvn03l67ga0AOiMEQL
1KfrDpdIlfMg+/+5n+31oLxLAfoohsBwqtMKBShSNfmCRwZosHCTHspiAEXacYIt
mexNljKYPbBQI8kIyHoPryk2YFNftCf9WejRedCKMRBZEFI/FkLki3LJXo02eXmn
bgWLQis09vKgOdu4BzARGC9Nc8O2XSOoJ7VPI2/4kWYN42q0JWd4si/ihAEfcsrd
+rtH9aINMHxstSOXNrfI5PO0+Zx8wAAT4ueZdRYpsiMZHW1GbgPzwwaG0XXFx1SL
xAXBqHfWCm/u035Vu3P3dWkU0IcUtBHXa4YXoJv4oBZ9hDmjnnEGI5CFjX24mGBT
KtqgLgdag2WuAmfM/69ROee0/5GrTtS42JQFT930q0wnPtmXM+q7Lq4jjYYXhPrd
Ir5BYhPBL6JRvi0VkhiHDGIyoC+k9MS+K5b+uoPMjmaTnPDzQ3BDJ+dsSs1NUfWf
3hUpdj6+bCxeWSs7jAt3waewWyq0ik83ZIankaj1JesH0DM340+V4ZPGFgoDKD7X
2AtNOfA/ncUWXi8WJG7jb7xYu5tA/OScBycLmQt+44WNGjQSAVLPc1Zv4rjTSC43
BsM4rtu1+sFIFZw7LTtQoIq65thkrOWBbU3OnUNuP6ly+1U67YkNaYXeezfUZH9x
Wc6XrzlDaym4fuZGxWJT
=e/Gz
-----END PGP SIGNATURE-----

--KSn4sQg3MnruwCB4--
