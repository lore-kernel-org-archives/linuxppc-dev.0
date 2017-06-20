Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsJp34jwczDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:07:54 +1000 (AEST)
Date: Tue, 20 Jun 2017 09:07:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC PATCH 0/7 v1] powerpc: Memory Protection Keys
Message-ID: <20170620070749.GC30728@amd>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
In-Reply-To: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Memory protection keys enable applications to protect its
> address space from inadvertent access or corruption from
> itself.
>=20
> The overall idea:
>=20
>  A process allocates a   key  and associates it with
>  a  address  range  within    its   address   space.
>  The process  than  can  dynamically  set read/write=20
>  permissions on  the   key   without  involving  the=20
>  kernel. Any  code that  violates   the  permissions
>  off the address space; as defined by its associated
>  key, will receive a segmentation fault.

Do you have some documentation how userspace should use this? Will it
be possible to hide details in libc so that it works across
architectures? Do you have some kind of library that hides them?

Where would you like it to be used? Web browsers?

How does it interact with ptrace()? With /dev/mem? With /proc/XXX/mem?
Will it enable malware to become very hard to understand?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllIycUACgkQMOfwapXb+vIfewCfRfyhEb2y0Gr9TeVhfXPG+sIk
b5wAoKwnWJyjAdk99neXgO/s1nqNtq81
=u4PP
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
