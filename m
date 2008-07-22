Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDCDEDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 13:34:20 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6M3XIN6023338
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 13:33:18 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6M3YK0I3334364
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 13:34:20 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6M3YJVR022707
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 13:34:20 +1000
Date: Tue, 22 Jul 2008 13:34:17 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: gigantci pages patches
Message-ID: <20080722033417.GD14888@yookeroo.seuss>
References: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
Cc: npiggin@suse.de, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 05:45:15PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Could people take one last look at these patches and if there are no
> issues, please send Ack-bys to Andrew who will push them to Linus for
> 2.6.27.
>=20
> [PATCH 1/6 v2] allow arch specific function for allocating gigantic pages
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18437
> Patch: [PATCH 2/6 v2] powerpc: function for allocating gigantic pages
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18438
> Patch: [PATCH 3/6 v2] powerpc: scan device tree and save gigantic page lo=
cations
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18439
> Patch: [PATCH 4/6 v2] powerpc: define page support for 16G pages
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18440
> Patch: [PATCH 5/6 v2] check for overflow
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18441
> Patch: [PATCH 6/6] powerpc: support multiple huge page sizes
> http://patchwork.ozlabs.org/linuxppc/patch?&id=3D18442

Sorry, I should have looked at these properly when they went past in
May, but obviously I missed them.

They mostly look ok.  I'm a bit confused on 2/6 though - it seems the
new powerpc alloc_bootmem_huge_page() function is specific to the 16G
gigantic pages.  But can't that function also get called for the
normal 16M hugepages depending on how the hugepage pool is
initialized.

Or am I missing something (wouldn't surprise me given my brain's
sluggishness today)?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIhVU5aILKxv3ab8YRAvZzAKCHw5WJ+PLTPhWvgEJ/YUyI2ZaeSACfd31y
ma3QldEChxYGSmJRFWO98oI=
=S6LE
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
