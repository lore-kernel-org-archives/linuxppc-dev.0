Return-Path: <emunson@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9856BDDF67
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 07:24:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6SLO15C002128
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 17:24:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6SLO1at221108
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 17:24:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6SLO0OQ004447
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 17:24:00 -0400
Date: Mon, 28 Jul 2008 14:23:54 -0700
From: Eric B Munson <ebmunson@us.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-ID: <20080728212354.GB8450@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<1217277204.23502.36.camel@nimitz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <1217277204.23502.36.camel@nimitz>
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2008, Dave Hansen wrote:

> On Mon, 2008-07-28 at 12:17 -0700, Eric Munson wrote:
> >=20
> > This patch stack introduces a personality flag that indicates the
> > kernel
> > should setup the stack as a hugetlbfs-backed region. A userspace
> > utility
> > may set this flag then exec a process whose stack is to be backed by
> > hugetlb pages.
>=20
> I didn't see it mentioned here, but these stacks are fixed-size, right?
> They can't actually grow and are fixed in size at exec() time, right?
>=20
> -- Dave

The stack VMA is a fixed size but the pages will be faulted in as needed.

--=20
Eric B Munson
IBM Linux Technology Center
ebmunson@us.ibm.com


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIjjjqsnv9E83jkzoRAugvAKD36x3OyfiN/GtGM+x0LJ6SL7e7TgCdHOOf
OGGM1jiwgdCWkwRUj/Gd/Fg=
=5CJt
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
