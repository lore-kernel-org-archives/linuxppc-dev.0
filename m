Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bTky2x17zF2TN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 17:03:22 +1000 (AEST)
Date: Wed, 2 May 2018 17:03:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel 2/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical pages
Message-ID: <20180502070317.GE3517@umbus.fritz.box>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-3-aik@ozlabs.ru>
 <20180502155323.30c41ce4@balbir.ozlabs.ibm.com>
 <c04cd729-fd88-ed46-cfcb-93324bb243f3@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
In-Reply-To: <c04cd729-fd88-ed46-cfcb-93324bb243f3@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 04:26:04PM +1000, Alexey Kardashevskiy wrote:
> On 2/5/18 3:53 pm, Balbir Singh wrote:
> > On Wed,  2 May 2018 14:07:23 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
[snip]
> >> +	unsigned long subpg;
> >=20
> > Why not just i?
>=20
> I can imagine pages so huge so backing them with 4K will overflow 32bit
> anyway. It is very (very) unlikely but it is 64bit arch anyway and there =
is
> no much point in not-long types anyway.

I think Balbir was talking about the variable name, not the type.
i.e. "Why not call it 'i' the default name for a random loop
counter?".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrpYrAACgkQbDjKyiDZ
s5LpTxAAmuku1/TMl3mNyYqLtED4ZW+LKi6G4wfIYLraAHGhDnDThC5Z0sypo3OO
ppvgXl+5MhbRoKNlDPEEzrfEisZyY//oqCXAPmXzz3eBMkzCkv+jlyXuJz1EQWrD
Y0gOdlGytUHRLyQPUsGHgEZzWLXkyNHrxNj4JfvXX4qhRrOqx0RDgNkRaO71zrh7
5/2KX4Mp0dsmLbJz7rdhekzcJ4AcUaonanpgolxFWY3amIvuNWt8vd1hDPQTcxPq
h6eU4uATf2wJPqSd8ai7OIU1ba33gWPSyPTPYbp2/QTt/yDDiwm3NEEl+Y6mb4Da
syPnq2aIJDEBqIYrd2D+gmtnV+gvqXWpGwLvgwrvMvijID1yQncjgtzsJZk4emXp
j+B5ZEhTPOwsLVJ/vzhKGCMuvDtrZXBnVbfCnGc/8gHZzgKoGf3UzVN7fNt7o6Qa
d7upN/oXjYVmmcmBDzbLY5kN/4m73n0z5NnOuLLCMooe/wASAtwg6CvYvKQHpzPz
SYMgERMyAedyYX55g4ZosLHdSueMq2YKw7hIWopxDMLIdUywaggoDhO3GyN/ubhw
2JVDH2zGyZz/EthUixWr2hJ2zu4IWIkAjSnNVcPp18YKLx9X5vZFQMPT48EqJ2y2
7e923Rkfr6RfJ38ueWVtMu//77EDU25N+Hc3J2nZLK4VC4Qja3A=
=bmLM
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
