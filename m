Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shXjm1ZtyzDrPP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:33:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds   <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ruscur@russell.cc, aik@ozlabs.ru <aik@ozlabs.ru>,
 benh@kernel.crashing.org <benh@kernel.crashing.org>,
 Gavin Shan  <gwshan@linux.vnet.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-7 tag
Date: Sun, 25 Sep 2016 13:32:55 +1000
Message-ID: <87vaxk7ixk.fsf@concordia.ellerman.id.au>
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

Please pull one more powerpc fix for 4.8:

The following changes since commit ed7d9a1d7da6fe7b1c7477dc70e95051583fd60c:

  powerpc/powernv/pci: Fix missed TCE invalidations that should fallback to OPAL (2016-09-15 17:05:11 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-7

for you to fetch changes up to b79331a5eb9f96e4dfd216974581168ec4c8a4d4:

  powerpc/powernv/pci: Fix m64 checks for SR-IOV and window alignment (2016-09-21 14:04:13 +1000)

----------------------------------------------------------------
powerpc fixes for 4.8 #7

 - powernv/pci: Fix m64 checks for SR-IOV and window alignment from Russell Currey

----------------------------------------------------------------
Russell Currey (1):
      powerpc/powernv/pci: Fix m64 checks for SR-IOV and window alignment

 arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX50VoAAoJEFHr6jzI4aWAPsQP+gI8zeBXiY18yiLdgtmRoJhD
jRNtlaahTbENFIxABHsDw6kiXM7orkji8l+C7ISnpsVqW5mbkndw/K70U/Fk0ENw
E0ag0Z7zYNObJfEZotXZzg3Z0lheF4paL+1l4kBiyahuGmcX2/7zxY6F56qrPRPQ
I1t1BTuDGyX9ZezqD9JLHql54ukIMNAJIQT+pi8wiFElYp4A8+wlFXk2T35fUcq9
7iVYa1Nb3rCPbavCQUZ/MgyFSi7aWMbnHoHOyoTJ4eBCusK84QbO0fZlP2H60HMR
8iAUHJwFl7mwy5jOCZrSQHUcQ/S9nTCi27/o6FaC0uwhoEFXAgZw0SHwI0U0Vlym
aJ0QJdJuApzh6MIFDyHDlUK7fgTYVxiz38WkU58BsbM34RlxPHzRJKJMHivtbT0L
+ATNMIT5z8p3+3Fc058jyGBbqXsg6tjbL08pMY34MgMQAEPzIV07fVOxpt72NiB4
QW8tLZM0PMLS3H0R6J93xp+Duq+pSMjXZAPp4lQaXcUXhg3a999UXTPCgIOmt/zv
3UCHmIOdYNsWluK5LWHaqhT3n1AqYaYJ1YtGQcNEIJip7FoY3IGsgFdVBkRgZIDL
BQY0Ne309V2yPO14qzQ/i9zRJRo8/78VFrhBB8HEGCGuXe+Dqx5QuxqT0UpXttzN
WF202YbROCliN+AKAF0Z
=oWxI
-----END PGP SIGNATURE-----
--=-=-=--
