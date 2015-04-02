Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A79F1A0895
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 20:48:16 +1100 (AEDT)
Message-ID: <1427968095.11277.1.camel@ellerman.id.au>
Subject: [git pull] Please pull mpe/linux.git powerpc-4.0-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 02 Apr 2015 20:48:15 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-NGAmeTCNHCUWCiu6aiLu"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, jstancek@redhat.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-NGAmeTCNHCUWCiu6aiLu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull one powerpc fix for 4.0:

The following changes since commit e42391cd048809d903291d07f86ed3934ce138e9=
:

  Linux 4.0-rc6 (2015-03-29 15:26:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git tags/powerpc-=
4.0-4

for you to fetch changes up to d52356e7f48e400ca258c6763a232a92fa82ff68:

  powerpc: fix memory corruption by pnv_alloc_idle_core_states (2015-04-01 =
12:05:44 +1100)

----------------------------------------------------------------
powerpc fixes for 4.0 # 3

 - fix memory corruption by pnv_alloc_idle_core_states

----------------------------------------------------------------
Jan Stancek (1):
      powerpc: fix memory corruption by pnv_alloc_idle_core_states

 arch/powerpc/include/asm/cputhreads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



--=-NGAmeTCNHCUWCiu6aiLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVHRBfAAoJEFHr6jzI4aWA/k0QAJHPQk07rP04X3JsAALHkami
9q/wUCObuEfaPMUrBjjNee6eh9ZpbnhDuX7I3ZSIlrFKlkX8Q54+XRW+MZtaPEzz
fivpIrmJp0IN8jYh9Od5jVaxvBAG7d738A12CnZ8ZOvbCQGvQBfKcJbBLOA2J+60
KqQHH6kmz9cOVWUZQuoMVOxonygHJ38Z39dmnXUrymVr8STmZ8PDMchqsiq86sMG
2kjHGdKIorKteqIoCZyam+cQVtcFpRFr2zwZAUDHZm1KPzkyBDhj4iMoOoF2dhS7
w719DoJpYdmP1rifztiLHZd9tPYpBrcyQ0jN3/W/6l0sviUDU6aOEbz6g33nPQuu
0Clo+oymqAHVrT4S9znIfqizsDkdySa4thZWk4oYmwnzSSdZTL+Jmsq/9/Co+SyZ
a3ZGIbXqWVsJkt9JEMb4I/UFjXjrW73pK+yz1U9gh8jatUrACzoynS1xLpFwY4lV
YkC8zzYk9XOzI7Qkc/dPvRcWUqfX7pIN/tzs4Zwvdg+ZNlvg4PoAzL9jaZB3AJVE
0v6BktGRMM7YrNEO9Xke9SOckyWKv3GMyoHYDhSfKsz9Me1VNzi3dBgBOM+fX1HO
fj2x+R0m95tGLcSi0E2r9G6Dl+69WISla9vGohA94cDYgcpnJhJNZwIuwsiEoPP7
59+FQvTweNWj/bph+4M0
=O6Rm
-----END PGP SIGNATURE-----

--=-NGAmeTCNHCUWCiu6aiLu--
