Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82DE01A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 10:08:26 +1000 (AEST)
Message-ID: <1438560499.8863.0.camel@ellerman.id.au>
Subject: [git pull] Please pull powerpc/linux.git powerpc-4.2-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, alistair@popple.id.au, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 luis.henriques@canonical.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 03 Aug 2015 10:08:19 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-Of+8wDFqmeFLtQ2VsC8E"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Of+8wDFqmeFLtQ2VsC8E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.2:

The following changes since commit c5dfd654d0ec0a28fe81e7bd4d4fd984a9855e09=
:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2015-07-22=
 14:45:25 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.2-3

for you to fetch changes up to b8d65e9662b1ffb3b52a65fd11b0b968022dc6a1:

  powerpc/eeh-powernv: Fix unbalanced IRQ warning (2015-07-30 19:01:32 +100=
0)

----------------------------------------------------------------
powerpc fixes for 4.2 #2

- TCE table memory calculation fix from Alexey
- Build fix for ans-lcd from Luis
- Unbalanced IRQ warning fix from Alistair

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Fix calculation for memory allocated for TCE t=
able

Alistair Popple (1):
      powerpc/eeh-powernv: Fix unbalanced IRQ warning

Luis Henriques (1):
      macintosh/ans-lcd: fix build failure after module_init/exit relocatio=
n

 arch/powerpc/platforms/powernv/eeh-powernv.c |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    | 11 ++++++-----
 drivers/macintosh/ans-lcd.c                  |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)



--=-Of+8wDFqmeFLtQ2VsC8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVvrDzAAoJEFHr6jzI4aWAYZUP/RpEjp7CIJK8y/1uWrigactb
W8i121f11AwW2YTMvKu8P2QuhqHe8pznGwMeJbmDmUS8GTuNxQRViiV0KwL0mTTx
vOT1zi3tlMSuG7smvRsXIUXvk+ZHHAMGp8+1qJXjodhwQEK0LyPZI9tqm7fOsvxn
NkIeVDXVWJWeB46HhHd20OGqpPNgsksm5F6zGjx6EcDhHCoprtRlroIiHnqhULGe
s9ZtxehXss6ArCu8Uos4D5PgsHNt+/mPRdz5+8XJfwH00dR+uQJBg9n3uX12c7Gy
C6SgDynqyyBK7yKofr9QnQ1Pm4MllkOi4TSTRNRFAer9+vytDKcFwz7p+aGw+12z
FBZF4gw8HnlNNh/dFPQAQGbF7bFyAXvR4k4zPGkYfCUJx9NhXOd+rBjVVdfmT+59
KRhikUirE2PLT38ooB5yS1Q8tFrcZO6Sp5UqU4X0dt55/goeUUJyyuk1vc3A6O+v
Db+tRO8TgHET5fjrxVcgR55cvOTZtW4+QvUKpWlgg/sl8vL8lf6aOV0OXoMF1hi0
elyjzwQzocYnrsFNrFxFkV+/watWCivPP082Enq6kr9fkthg6OjUJR4NbBMVtJJJ
fRWTi8F7OppyfSz2/CbnF4EJWi14zzFiHOSKTL0kTfyND2XEnca+5lz6OJLJwN2f
JlxYBTVihGGWhSZ5i5Re
=ULZx
-----END PGP SIGNATURE-----

--=-Of+8wDFqmeFLtQ2VsC8E--
