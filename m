Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D9C2667C84
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:30:57 +1000 (EST)
Date: Tue, 3 Oct 2006 22:30:54 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull upstream branch of linux-2.6-PQ.git...
Message-ID: <20061003223054.06e25136@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_lgn0RIwQHxtKOfpaIBX0IwE;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_lgn0RIwQHxtKOfpaIBX0IwE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Paul,

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-PQ.git, upstre=
am branch.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


To receive the updated 8272 addition to the  arch/powerpc.
All the comments have been addressed, and it has a minor bugfix addressed t=
oo in order to make both pq2 and pq3
co-exist happily in fsl_soc.c. CPM PIC now has "compatible" property that c=
ould be "CPM2" or "CPM1" for PQ/8xx.

I think it should go to rc1, because relevant stuff in ppc/ is more or less=
 broken now, with new irq engine.=20

--

 arch/powerpc/Kconfig                      |    1=20
 arch/powerpc/boot/dts/mpc8272ads.dts      |  223 ++++++++++
 arch/powerpc/platforms/82xx/Kconfig       |   21=20
 arch/powerpc/platforms/82xx/Makefile      |    5=20
 arch/powerpc/platforms/82xx/m82xx_pci.h   |   19=20
 arch/powerpc/platforms/82xx/mpc82xx.c     |  111 +++++
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |  661 +++++++++++++++++++++++++=
+++++
 arch/powerpc/platforms/82xx/pq2ads.h      |   67 +++
 arch/powerpc/sysdev/cpm2_pic.c            |    2=20
 arch/powerpc/sysdev/cpm2_pic.h            |    2=20
 arch/powerpc/sysdev/fsl_soc.c             |   62 ++
 11 files changed, 1165 insertions(+), 9 deletions(-)

commit 91bd61099defb28a442db358dd9c1693c6589cee
Author: Vitaly Bordug <vbordug@ru.mvista.com>
Date:   Mon Oct 2 22:45:17 2006 +0400

    POWERPC: mpc82xx merge: board-specific/platform stuff(resend)
   =20
    This intruduces 82xx family in arch/powerpc/platforms,
    and has all the board-specific code to represent regression-less
    transaction from ppc. The functionality is apparently the same, includi=
ng
    PCI controller.
   =20
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

commit ed943c1faba53d9a0bde56007ee27762b29dccbd
Author: Vitaly Bordug <vbordug@ru.mvista.com>
Date:   Mon Oct 2 22:41:50 2006 +0400

    POWERPC: 8272ads merge to powerpc: common stuff
   =20
    This has modules of common directories related to the
    mpc8272ADS board, mainly common cpm2 changes and fsl_soc.c
    portions related to the bitbang MDIO and other mechanisms specific
    for this family.
   =20
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

commit e02f73e9fd69f1c6d16c207f7a91ce721fe8beab
Author: Vitaly Bordug <vbordug@ru.mvista.com>
Date:   Mon Oct 2 22:22:36 2006 +0400

    POWERPC: Added devicetree for mpc8272ads board
   =20
    This adds current dts file used with MPC8272ADS,
    introducing new mdio bitbang defines, as well as
    fully-CPM2-SoC board design.
   =20
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

--
Sincerely, Vitaly

--Sig_lgn0RIwQHxtKOfpaIBX0IwE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIqxeuOg9JvQhSEsRAiAMAJ9fsfjtDv2A5vsfbbVN2iBxEj2vzgCcDGXc
REVEOraLr64GJyuJ0gyOvPs=
=AScf
-----END PGP SIGNATURE-----

--Sig_lgn0RIwQHxtKOfpaIBX0IwE--
