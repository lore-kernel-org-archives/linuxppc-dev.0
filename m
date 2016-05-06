Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1PPK75mRzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 18:01:41 +1000 (AEST)
Message-ID: <1462521695.26109.2.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-5 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 06 May 2016 18:01:35 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-kJgcEEr3PNc2drBLfqUg"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-kJgcEEr3PNc2drBLfqUg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull one powerpc fix for 4.6:

The following changes since commit d701cca6744fe0d67c86346dcfc9b128b17b5045=
:

  powerpc: wire up preadv2 and pwritev2 syscalls (2016-04-27 16:47:55 +1000=
)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.6-5

for you to fetch changes up to b4c112114aab9aff5ed4568ca5e662bb02cdfe74:

  powerpc: Fix bad inline asm constraint in create_zero_mask() (2016-05-02 =
11:10:25 +1000)

----------------------------------------------------------------
powerpc fixes for 4.6 #4

 - Fix bad inline asm constraint in create_zero_mask() from Anton Blanchard

----------------------------------------------------------------
Anton Blanchard (1):
      powerpc: Fix bad inline asm constraint in create_zero_mask()

 arch/powerpc/include/asm/word-at-a-time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=-kJgcEEr3PNc2drBLfqUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXLE9fAAoJEFHr6jzI4aWA3EcP/3sE+Wn6TEojYKrjl1yY4anI
jQPIskOLjgy68b46fuYJUzh4pywUE40TgO8Qn8FY1wJ3yOt/ySDNP1P6WUOSvjb0
WPGC6LEjam7lEV7ZM6FFiJtbrfpc8n0Gzhjr0W7a5cFl1L6h0w6UjblWAkXIEhHu
bTIQSDOPXWGZeXw4AklSo0CdJKXZCaMJw/y+V0iMrSGEYNRxidzfnvUUs2t9hH+4
co31BmHgyQWdBt3lATQ5ThjhtS1vFtAr7FqBAdo106t7sR7GGIN3Jm5oY/pPbRJj
XjmwTahy7A0ECKItuuxyaRF9SPaOvX45hsf5RZkgKavsQ7i+aUqg5Cc05joHc6+B
Nf7WgnaFBSZ+mkBRpFZedz4rV4Mrzjhhw9TYq9nnqnivz3tPjRBh+DoRI/gIpZBd
g7oSg7qZbv3AMiclttblb+4id5K/Wsg/V4pOGo6Ku3kf2F9Ekak4qeXs0142notB
OPNYfta+MP15riXnsy/vYJVEkaVb/GdyuAL/+/lgWgC6J1hBr4rZMnpxED0uafiN
fboSNdeaK+m5QwfBMpFpvl0lkzl6v7NNd4Ie/DoGkZKfN5ukbK1Pj/FGpwTk8hMH
dN4uXhq8aOuYDU1yezDVcgAVC4mO8IYwXur/TSCAndx6K9fCjR4WA2tYga0IkUMv
JIO++GIpVjrUgO4gpqKh
=Wbk4
-----END PGP SIGNATURE-----

--=-kJgcEEr3PNc2drBLfqUg--
