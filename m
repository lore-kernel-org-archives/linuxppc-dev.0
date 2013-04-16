Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 9140E2C0106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 18:08:30 +1000 (EST)
Date: Tue, 16 Apr 2013 18:08:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: [git pull] Please pull one last set of fixes for powerpc for v3.9
Message-Id: <20130416180826.ec3339c791d3f2311f1dc0f1@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__16_Apr_2013_18_08_26_+1000_ETMYuHClz8=RvH/S"
Cc: Michael Neuling <mikey@neuling.org>, Kevin Hao <haokexin@gmail.com>,
 Tiejun Chen <tiejun.chen@windriver.com>,
 Alistair Popple <alistair@popple.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__16_Apr_2013_18_08_26_+1000_ETMYuHClz8=RvH/S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e8f2b548de7ae65e17ee911e54712a3f26f69c60:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git=
/viro/vfs (2013-04-09 12:22:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sfr/next-fixes.git tags/for=
-linus

for you to fetch changes up to d8b92292408831d86ff7b781e66bf79301934b99:

  powerpc: add a missing label in resume_kernel (2013-04-15 17:29:48 +1000)

----------------------------------------------------------------
Three regresions in the PowerPC code.  One from v3.7 the others from
this merge window.

Please pull - thanks a lot.

----------------------------------------------------------------
Alistair Popple (1):
      powerpc: Fix audit crash due to save/restore PPR changes

Kevin Hao (1):
      powerpc: add a missing label in resume_kernel

Michael Neuling (1):
      powerpc: fix compiling CONFIG_PPC_TRANSACTIONAL_MEM when CONFIG_ALTIV=
EC=3Dn

 arch/powerpc/kernel/entry_64.S  | 4 ++--
 arch/powerpc/kernel/process.c   | 2 ++
 arch/powerpc/kernel/signal_32.c | 2 ++
 arch/powerpc/kernel/signal_64.c | 2 ++
 arch/powerpc/kernel/tm.S        | 2 ++
 5 files changed, 10 insertions(+), 2 deletions(-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__16_Apr_2013_18_08_26_+1000_ETMYuHClz8=RvH/S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRbQb6AAoJEECxmPOUX5FEsXYP/R2BY93nAKeZA37DkzzRcZXv
GpCe1Qzja0q4drcA8gVb2syl+8F0PpHG/zHraiIl1yUX/TorJsf16mP4KKC0fPB/
Tu9R+5m7gGn48nQ+wa3ytoYnl77989h2C9UWzAveaXEg1tUzwSIzG153pCcWRxRf
0wp6/4Au0s8Fm2da3xfEV9wvNUgfdocj2CcbRM9QdHYmd9kJOsT52rS0mo3SV3zS
qTkCGR0YAQQBLW9yZeSQrqibQsOK3mWr6TEgKCFs9+CjSQB9DTdF260e0CDeNWsx
bL8Wen1eTSvMbaE36ZmWJcGROf7XPsWj8XM4MypsFCM73W9MsRGfAX9Qj4Dq5Ktk
pWNmKRcNfOECb2hbvK/zUEg9ETJnkl3sTGSKfQLIlxSCjJBuQrzYdldfESkupBJx
4AXVfCr6m/CL12o//F1ctelsPV9LfmpiOQYeiKNZlIepH779gyIO5kvZCLubd9k9
R12dz5BnvUiGv2rXAx+LTaqNCIqImTvqS6lHF6sRD2dyynSij1NSuakHX9rzTChx
MnNjr2kbKdFRQjHEy4gRbWKncOS4xoveQ+Dl/S4XycC4gLjoWgdpuLXAeA2IqZE2
GvN4rd8h45A3W8tBUHceV9egEzzLt26w5ot4LkOD7ij7/6m+U8PA1+RW41fAx3Uy
YBcltbI/iCwD1ziPBdbZ
=6Wwq
-----END PGP SIGNATURE-----

--Signature=_Tue__16_Apr_2013_18_08_26_+1000_ETMYuHClz8=RvH/S--
