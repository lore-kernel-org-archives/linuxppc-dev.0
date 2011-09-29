Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
	[IPv6:2001:a60:0:70:0:1:25:1])
	by ozlabs.org (Postfix) with ESMTP id 68DECB6F62
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 19:30:40 +1000 (EST)
Date: Thu, 29 Sep 2011 11:30:25 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20110929113025.2b224cd3@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

please pull another two mpc5xxx patches for next. These patches were
queued in Grant's 'powerpc/next' branch a while ago, but a pull request
have never been submitted for them. Thanks!

Anatolij

The following changes since commit 7680057cc4c7d9caada12767831bfd9738dd7b43:

  powerpc: Don't try OPAL takeover on old 970 blades (2011-09-29 17:04:59 +1000)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Grant Likely (1):
      powerpc/5200: add support for charon board

Heiko Schocher (1):
      powerpc, tqm5200: update tqm5200_defconfig to fit for charon board.

 arch/powerpc/boot/dts/charon.dts             |  236 ++++++++++++++++++++++++++
 arch/powerpc/configs/52xx/tqm5200_defconfig  |   20 ++-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 3 files changed, 249 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/charon.dts
