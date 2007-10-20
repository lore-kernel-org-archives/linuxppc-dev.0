Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DFA23DDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 12:37:18 +1000 (EST)
Date: Fri, 19 Oct 2007 21:43:55 -0500
From: Olof Johansson <olof@lixom.net>
To: scott.wood@freescale.com
Subject: ep88xc_defconfig doesn't build
Message-ID: <20071020024355.GA20356@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Did it ever?! I get this with current mainline when building default target:

  WRAP    arch/powerpc/boot/cuImage.8xx
DTC: dts->dtb  on file "/work/work/linux/k.org/arch/powerpc/boot/dts/ep88xc.dts"
ERROR: Missing /chosen node
Input tree has errors
  WRAP    arch/powerpc/boot/zImage.ep88xc
make[1]: *** [arch/powerpc/boot/cuImage.8xx] Error 1
make[1]: *** Waiting for unfinished jobs....
DTC: dts->dtb  on file "/work/work/linux/k.org/arch/powerpc/boot/dts/ep88xc.dts"
ERROR: Missing /chosen node
Input tree has errors
make[1]: *** [arch/powerpc/boot/zImage.ep88xc] Error 1
make: *** [zImage] Error 2



-Olof
