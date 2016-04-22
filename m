Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrsYC0QyKzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 20:38:55 +1000 (AEST)
Message-ID: <1461321534.22163.3.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 22 Apr 2016 20:38:54 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-kYwVdCxFYuIpTRpa8b9q"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-kYwVdCxFYuIpTRpa8b9q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull a few powerpc fixes for 4.6:

The following changes since commit 71528d8bd7a8aa920cd69d4223c6c87d5849257d=
:

  powerpc: Correct used_vsr comment (2016-03-29 12:08:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.6-3

for you to fetch changes up to 4705e02498d6d5a7ab98dfee9595cd5e91db2017:

  powerpc: Update TM user feature bits in scan_features() (2016-04-18 20:10=
:45 +1000)

----------------------------------------------------------------
powerpc fixes for 4.6 #2

 - scan_features() updates incorrect bits for REAL_LE from Anton Blanchard
 - Update cpu_user_features2 in scan_features() from Anton Blanchard
 - Update TM user feature bits in scan_features() from Anton Blanchard

----------------------------------------------------------------
Anton Blanchard (3):
      powerpc: scan_features() updates incorrect bits for REAL_LE
      powerpc: Update cpu_user_features2 in scan_features()
      powerpc: Update TM user feature bits in scan_features()

 arch/powerpc/include/uapi/asm/cputable.h |  1 +
 arch/powerpc/kernel/prom.c               | 26 +++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

--=-kYwVdCxFYuIpTRpa8b9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXGf8+AAoJEFHr6jzI4aWAbBAQAKT4iKcFyiEWezjlDq/nXJlT
UNtimpU+xRYz7Dqhwy/xEn/Q1cPbOzHaJrXPgyv0mzbmgZBKhu/38lnBr3C+on2E
4Q7I8n3LzmM/CyqtzpvHsjjADYFbQC6V5s9vZW7nZFMck2mF1SO8BNhH/LAKoiJS
GmQ4hLC1eB1hNM+JjRH42eRRQXqdgSedNzjF7Rum73UvHs/kRYt/PjgU4e5sgSQA
8J9FRWvqgeUP40AVBH4MTRSx11v9hCus2aSsT8K/2FqZxa/oMGjiT7EIGug5coCE
day2HG0yI4c5w6iEeqUV6U4nqrD7i6t0p9BWVM+1ZIXR5+DuWn2az8s+TgDbUK+V
S+ZzpqDarNxyR2TMCK3WMyDuCib+FhxJA8H/Ng0W3yUYen18vVQreq+iVrCTPhnO
VYJdlDNZOpRodCQx2IG4FxrPCGtmjQTbVo7QDHJ08uit2oF/1CQk3B1K0mXqQlvD
Df4XA3ulbVW1mdHZgfxGu2Y+CCZCl1kGwuGMdme9EGtucCCKBnqRy7XVrO5OZJBb
2QzrUQYr73vLeRXkcFTsUXjo+WAOFrx9JVMg6L1Ts8DhEEA2ewuQ3dUly+wfjkXD
XPH+Q7eTJJu4qcB84ujVjhNTOX85gaYOhwvfzM0UzQuFzMSuM2Tfwcu52wcYUNWd
hv/GzG+zwQugTA8pCRR0
=QAi8
-----END PGP SIGNATURE-----

--=-kYwVdCxFYuIpTRpa8b9q--
