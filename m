Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC62BDDF4C
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 17:13:20 +1100 (EST)
Subject: [git pull] Please pull from powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/alternative; boundary="=-l7le0IuedpIlKmenWaKH"
Date: Mon, 02 Feb 2009 17:13:09 +1100
Message-Id: <1233555189.18767.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-l7le0IuedpIlKmenWaKH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus !

Some updates for 2.6.29. Note the atyfb change. This is a fix shielded
in #ifdef CONFIG_PPC, there is no fbdev maintainer, so Andrew and I
decided to send it via my tree. It's a simple workaround for an ooooold
regression.

The rest is mostly small stuff from Grant who missed -rc2 probably due
to being away (defconfig updates, a small bug fix), a regression fix
in our PCI code and a lost patch in Stephen serie of u64 conversion.

Cheers,
Ben.

The following changes since commit 45c82b5a770be66845687a7d027c8b52946d59af:
  Linus Torvalds (1):
        Merge branch 'header-fixes-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc: Fix oops on some machines due to incorrect pr_debug()

Grant Likely (3):
      powerpc/5200: update defconfigs
      powerpc/5200: Bugfix for PCI mapping of memory and IMMR
      powerpc/5200: update device tree binding documentation

Risto Suominen (1):
      fbdev/atyfb: Fix DSP config on some PowerMacs & PowerBooks

Stephen Rothwell (1):
      powerpc/ps3: Printing fixups for l64 to ll64 convserion drivers/net

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |  180 +++++++++++++
 .../powerpc/mpc52xx-device-tree-bindings.txt       |  277 --------------------
 arch/powerpc/configs/52xx/cm5200_defconfig         |   83 +++++--
 arch/powerpc/configs/52xx/lite5200b_defconfig      |   86 +++++--
 arch/powerpc/configs/52xx/motionpro_defconfig      |   85 +++++--
 arch/powerpc/configs/52xx/pcm030_defconfig         |   82 ++++--
 arch/powerpc/configs/52xx/tqm5200_defconfig        |   89 +++++--
 arch/powerpc/configs/mpc5200_defconfig             |  104 ++++++--
 arch/powerpc/kernel/pci-common.c                   |    5 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |   24 +-
 drivers/net/ps3_gelic_wireless.c                   |    2 +-
 drivers/video/aty/mach64_ct.c                      |   11 +
 12 files changed, 590 insertions(+), 438 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
 delete mode 100644 Documentation/powerpc/mpc52xx-device-tree-bindings.txt


--=-l7le0IuedpIlKmenWaKH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.24.1.1">
</HEAD>
<BODY>
<PRE>
Hi Linus !

Some updates for 2.6.29. Note the atyfb change. This is a fix shielded
in #ifdef CONFIG_PPC, there is no fbdev maintainer, so Andrew and I
decided to send it via my tree. It's a simple workaround for an ooooold
regression.

The rest is mostly small stuff from Grant who missed -rc2 probably due
to being away (defconfig updates, a small bug fix), a regression fix
in our PCI code and a lost patch in Stephen serie of u64 conversion.

Cheers,
Ben.

The following changes since commit 45c82b5a770be66845687a7d027c8b52946d59af:
&nbsp; Linus Torvalds (1):
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Merge branch 'header-fixes-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

&nbsp; git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerpc: Fix oops on some machines due to incorrect pr_debug()

Grant Likely (3):
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerpc/5200: update defconfigs
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerpc/5200: Bugfix for PCI mapping of memory and IMMR
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerpc/5200: update device tree binding documentation

Risto Suominen (1):
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fbdev/atyfb: Fix DSP config on some PowerMacs &amp; PowerBooks

Stephen Rothwell (1):
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerpc/ps3: Printing fixups for l64 to ll64 convserion drivers/net

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |&nbsp; 180 +++++++++++++
 .../powerpc/mpc52xx-device-tree-bindings.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 277 --------------------
 arch/powerpc/configs/52xx/cm5200_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 83 +++++--
 arch/powerpc/configs/52xx/lite5200b_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 86 +++++--
 arch/powerpc/configs/52xx/motionpro_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 85 +++++--
 arch/powerpc/configs/52xx/pcm030_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 82 ++++--
 arch/powerpc/configs/52xx/tqm5200_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 89 +++++--
 arch/powerpc/configs/mpc5200_defconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 104 ++++++--
 arch/powerpc/kernel/pci-common.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 5 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 24 +-
 drivers/net/ps3_gelic_wireless.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +-
 drivers/video/aty/mach64_ct.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 11 +
 12 files changed, 590 insertions(+), 438 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
 delete mode 100644 Documentation/powerpc/mpc52xx-device-tree-bindings.txt

</PRE>
</BODY>
</HTML>

--=-l7le0IuedpIlKmenWaKH--
