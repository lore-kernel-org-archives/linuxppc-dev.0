Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A20202C0097
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jul 2013 08:36:10 +1000 (EST)
Date: Tue, 2 Jul 2013 00:36:05 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20130702003605.2838c666@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull mpc5xxx patches for v3.11. There are small cleanups
and fixes for mpc512x common code, mpc512x_defconfig updates and
soft reboot support for mpc5125 based boards.

Thanks,

Anatolij

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git next

for you to fetch changes up to dd0120dea601de654a5a6d959da3a632a02200f0:

  powerpc/mpc512x: enable USB support in defconfig (2013-06-25 08:51:19 +0200)

----------------------------------------------------------------
Anatolij Gustschin (1):
      powerpc/mpc512x: enable USB support in defconfig

Gerhard Sittig (3):
      powerpc/mpc512x: move common code to shared.c file
      powerpc/mpc512x: initialize board restart earlier
      powerpc/mpc512x: commit re-generated defconfig

Matteo Facchinetti (1):
      powerpc/mpc512x: add MPC5125 reset module support for system restart

 arch/powerpc/configs/mpc512x_defconfig        |   27 ++++++++-------------
 arch/powerpc/include/asm/mpc5121.h            |    1 -
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    6 ++---
 arch/powerpc/platforms/512x/mpc512x.h         |   12 +++-------
 arch/powerpc/platforms/512x/mpc512x_generic.c |    4 ++--
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   31 ++++++++++++++++++++++---
 arch/powerpc/platforms/512x/pdm360ng.c        |    4 ++--
 7 files changed, 47 insertions(+), 38 deletions(-)
