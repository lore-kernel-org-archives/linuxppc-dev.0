Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 278E42C00B3
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Dec 2013 23:12:59 +1100 (EST)
Date: Sat, 28 Dec 2013 13:05:43 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'merge' branch of 5xxx tree
Message-ID: <20131228130543.08a7e1c8@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull two DTS fixes for MPC5125 tower board. Without
them the v3.13-rcX kernels do not boot.

Thanks,
Anatolij

The following changes since commit 803c2d2f84da9dc2619449994af34d27148ab20d:

  powerpc/powernv: Fix OPAL LPC access in Little Endian (2013-12-13 15:55:15 +1100)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git merge

for you to fetch changes up to 11daf32be9a6041a2406c2cbf76b75a9c4a6eaaa:

  powerpc/512x: dts: disable MPC5125 usb module (2013-12-20 22:12:07 +0100)

----------------------------------------------------------------
Gerhard Sittig (1):
      powerpc/512x: dts: remove misplaced IRQ spec from 'soc' node (5125)

Matteo Facchinetti (1):
      powerpc/512x: dts: disable MPC5125 usb module

 arch/powerpc/boot/dts/mpc5125twr.dts |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
