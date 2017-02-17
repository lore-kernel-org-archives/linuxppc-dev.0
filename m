Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPsZv0ctgzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 23:21:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulus@ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.10-5 tag
Date: Fri, 17 Feb 2017 23:21:38 +1100
Message-ID: <87r32xhust.fsf@concordia.ellerman.id.au>
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

Please pull one last powerpc fix for 4.10. This is actually tagged for
stable, so it's not the end of the world if you'd rather not pull it
this late.

cheers


The following changes since commit f83e6862047e1e371bdc5d512dd6cabe8a3965b8:

  powerpc/powernv: Properly set "host-ipi" on IPIs (2017-02-09 15:51:21 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.10-5

for you to fetch changes up to 3f91a89d424a79f8082525db5a375e438887bb3e:

  powerpc/64: Disable use of radix under a hypervisor (2017-02-16 14:01:42 +1100)

----------------------------------------------------------------
powerpc fixes for 4.10 #5

One fix from Paul, we can not use the radix MMU under a hypervisor for now.
Although the current code checks if the processor supports radix, that is not
sufficient.

----------------------------------------------------------------
Paul Mackerras (1):
      powerpc/64: Disable use of radix under a hypervisor

 arch/powerpc/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYpurSAAoJEFHr6jzI4aWAY6kP/RB2QhRNurfnFnhbeLnCYi3U
jMXt9783Kf4WndBuWYbNWu5QxqSGblyCl1k7DzpKAFaFsEFXT51idA1AodzU67xS
F/hemO4rPV/mW9YTU0ajG8DsHYiIbb1GmYvdJNv1R40WAeepXKhW7V7E6pde1Ui9
pIDJZ+cTo5IM12KlXd2iet+gE4smpQkkF0qFLVSLX7q5afpZ5p4k9e8B8JS3gQUI
NG7HjtgQPdGTtqnKh0XOr9dJU9piZlis5SCVwQMZXwFtzWx8Iie/PSgq25uipZ4S
/zu3+l6eD4V+/izIl8udlWEfY13UOryosKWXtwnt+0wy42yLr6PNxcqX8bEzGWYQ
821WnY4IWm2DmDf3z2h6hAlFbVrus17uLIMMZjhGbRQ+/sk6WA6XbJoiBDR/cVmO
4POFLHIvL7srUPCuK7t7kcUqOTcWRDoWoTi4Hdv/YH4ltrOyHytAOkkmDN3aX9CK
KBkZCvQRffkyFJIGKM0lO855nvESVa4iaSNineOvGyZjd1lCsvw01qr7zc+OeIfC
MH4KpLxOTOVAeJTSL9ytSZysbE+5yIAulS64FVQQIvwv/GGdfxMDpdokykpWvfh0
3W3J3FWs1WEU4+8/wV/6Ki2k3wMf6klST1kaWlxLEw2tbsS1YKtgScNiEK8245m/
hoJNC595nnGn+Yza9iVH
=Ssq1
-----END PGP SIGNATURE-----
--=-=-=--
