Return-Path: <niklaus.giger@member.fsf.org>
Received: from fep15.mx.upcmail.net (fep15.mx.upcmail.net [62.179.121.35])
	by ozlabs.org (Postfix) with ESMTP id DB97DB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 20:43:03 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] Remove obsolete HCU4 board
Date: Fri, 22 Jul 2011 12:40:59 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107221240.59517.niklaus.giger@member.fsf.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I left Netstal Maschinen a couple of months ago. As I could never convince
my boss to give embedded Linux a real try, I would like to remove support
for this embedded board. I was the only user.

Many thanks for the friendly help I received on this list when I submitted
the patches for this board!

Patch is based on 
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

Niklaus Giger (1):
  Remove obsolete HCU4 board

 arch/powerpc/boot/dts/hcu4.dts          |  168 
-------------------------------
 arch/powerpc/configs/40x/hcu4_defconfig |   80 ---------------
 arch/powerpc/platforms/40x/hcu4.c       |   61 -----------
 3 files changed, 0 insertions(+), 309 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/hcu4.dts
 delete mode 100644 arch/powerpc/configs/40x/hcu4_defconfig
 delete mode 100644 arch/powerpc/platforms/40x/hcu4.c

-- 
1.7.5.4
