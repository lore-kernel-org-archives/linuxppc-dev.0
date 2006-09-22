Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0788E67BA1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 12:37:15 +1000 (EST)
Date: Fri, 22 Sep 2006 06:37:00 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull upstream branch of linux-2.6-PQ.git...
Message-ID: <20060922063700.79251139@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_YBxgkMpmd/C4Nv/A=GMZkLO";
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

--Sig_YBxgkMpmd/C4Nv/A=GMZkLO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Paul,

Refined 8560 series can be found in=20

git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-PQ.git, upstre=
am branch.

 arch/powerpc/boot/dts/mpc8560ads.dts       |  310 ++++++++++
 arch/powerpc/configs/mpc8560_ads_defconfig |  854 ++++++++++++++++++++++++=
+++++
 arch/powerpc/lib/Makefile                  |    5=20
 arch/powerpc/platforms/85xx/Kconfig        |   21=20
 arch/powerpc/platforms/85xx/Makefile       |    1=20
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |  218 +++++--
 arch/powerpc/platforms/85xx/mpc85xx_ads.h  |   61 ++
 arch/powerpc/sysdev/Makefile               |    5=20
 arch/powerpc/sysdev/cpm2_common.c          |  319 ++++++++++
 arch/powerpc/sysdev/cpm2_pic.c             |  290 +++++++++
 arch/powerpc/sysdev/cpm2_pic.h             |   10=20
 arch/powerpc/sysdev/fsl_soc.c              |  285 +++++++++
 arch/powerpc/sysdev/fsl_soc.h              |    2=20
 arch/ppc/platforms/mpc8272ads_setup.c      |    8=20
 arch/ppc/platforms/mpc866ads_setup.c       |    8=20
 arch/ppc/platforms/mpc885ads_setup.c       |   10=20
 drivers/net/fs_enet/fs_enet-main.c         |    5=20
 drivers/serial/cpm_uart/cpm_uart_core.c    |   24=20
 drivers/serial/cpm_uart/cpm_uart_cpm2.c    |  143 +++-
 drivers/serial/cpm_uart/cpm_uart_cpm2.h    |    2=20
 include/asm-powerpc/fs_pd.h                |   45 +
 include/asm-powerpc/mpc85xx.h              |   53 +
 include/asm-ppc/cpm2.h                     |   63 ++
 include/asm-ppc/fs_pd.h                    |   36 +
 include/linux/fs_enet_pd.h                 |   47 +
 include/linux/fs_uart_pd.h                 |   14=20
 26 files changed, 2674 insertions(+), 165 deletions(-)

Vitaly Bordug:
      POWERPC: Add cpm2 stuff support to the fsl_soc.c
      cpm_uart: make it possible to utilize from powerpc
      POWERPC: Move generic cpm2 stuff to powerpc
      POWERPC: Add support for the mpc8560 eval board
      POWERPC: Get rid of remapping the whole immr
      POWERPC: overhaul with cpm2_map mechanism
      POWERPC: Bring the fs_no calculation to the relevant SoC enumeration

--
Sincerely, Vitaly

--Sig_YBxgkMpmd/C4Nv/A=GMZkLO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFE0xMuOg9JvQhSEsRAoOaAJsEmOjGi3THo7CdOC4X1bHbZCJfhgCeMu9O
Nzj91O81/V4TsTw4gf+y5/M=
=km+Z
-----END PGP SIGNATURE-----

--Sig_YBxgkMpmd/C4Nv/A=GMZkLO--
