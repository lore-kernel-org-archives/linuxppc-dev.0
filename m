Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtqfP2G5QzDrVR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 19:21:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulus@ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-2 tag
Date: Fri, 15 Sep 2017 19:21:46 +1000
Message-ID: <87k210jp05.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull one powerpc fix for 4.14:

The following changes since commit bac65d9d87b383471d8d29128319508d71b74180:

  Merge tag 'powerpc-4.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2017-09-07 10:15:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.14-2

for you to fetch changes up to 1bc944cee663f232e3c37b15a6b2f9185bca413c:

  powerpc: Fix handling of alignment interrupt on dcbz instruction (2017-09-15 08:41:18 +1000)

----------------------------------------------------------------
powerpc fixes for 4.14 #2

Just one fix, for the handling of alignment interrupts on dcbz instructions.

Thanks to:
  Paul Mackerras, Christian Zigotzky, Michal Sojka.

----------------------------------------------------------------
Paul Mackerras (1):
      powerpc: Fix handling of alignment interrupt on dcbz instruction

 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZu5urAAoJEFHr6jzI4aWAAqYQAKmOwe3ywnu4KO5FlVRYk+X7
yunE8FWR+wUuNJuBKq+WvZCevvnXwNWzVpzPhFvVuPm3VcIqQdFPV14ylDWOz5dQ
d7axDnUMbozXHAw64QjKz6bS+5ZULIl5R7NRopcVIZZDxqhjz/RpzVLjA8/mAm+o
uGQ/99mPomGn/DzQrQfRu6q3OyLw06znkbdAwJGI/h70GDvB7Z//NMDSBRqZefAH
bV+nD4rCJQ5qzooOYtvaCIJiDtqIXxaylQFrUj/PDfm5d1ahaN63ewql73KCt1ZR
waSTl1kBFUPCEHqFWh5KKnkzQkPzTs/xDAeLW1iAY9UbdVTQS+TvJ7DadZA4FNL7
EoS6K3jdWs1HZ6U+yyBJlv80OVHLEWrWfW+F8vA8TomymcGGT7SLciBzCUEwxIFd
UF58uqJRQ8EYESV5JVNhzyiVdnrzBgQqdpWq9TQajtxdfkl7T+Ei70DxXJ4IpRz+
R4SU8m4euuCjy4P+x3BMfIbr5uI562DPJMeb+KNj7TxTPzgbSAzqYofi55XRlxsC
wZUNoyiRHTH98P73KB0UuYd9MO2uJlfqt+QMduYVxF+IwmTcH/Dnu6iAWYYmV93e
4cWfonGlDOT37GTYuIHxW0T0jp2eaqZ3ur12EZCKe3tSJufrQT2kl9+z+mEYSAGa
l22Cvipe3c6eRhJmB9Uk
=DezL
-----END PGP SIGNATURE-----
--=-=-=--
