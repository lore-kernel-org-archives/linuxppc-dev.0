Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC8D82C00A6
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Dec 2013 08:55:29 +1100 (EST)
Date: Mon, 9 Dec 2013 22:55:14 +0100
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Please pull 'merge' branch of 5xxx tree
Message-ID: <20131209225514.45f305c1@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull a device tree fix for v3.13. The booting on mpc512x
is broken since v3.13-rc1, this patch repairs it.

Thanks,
Anatolij

The following changes since commit 721cb59e9d95eb7f47ec73711ed35ef85e1ea1ca:

  powerpc/windfarm: Fix XServe G5 fan control Makefile issue (2013-11-27 11:35:47 +1100)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git merge

for you to fetch changes up to c65ec135960e4555f65d8c9243f65b2fb88ac071:

  powerpc/512x: dts: remove misplaced IRQ spec from 'soc' node (2013-12-07 09:43:28 +0100)

----------------------------------------------------------------
Gerhard Sittig (1):
      powerpc/512x: dts: remove misplaced IRQ spec from 'soc' node

 arch/powerpc/boot/dts/mpc5121.dtsi |    1 -
 1 file changed, 1 deletion(-)
