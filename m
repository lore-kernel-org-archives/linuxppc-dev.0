Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x231.google.com (mail-vk0-x231.google.com
 [IPv6:2607:f8b0:400c:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdD2L6yr2zF0gw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 22:52:26 +1100 (AEDT)
Received: by mail-vk0-x231.google.com with SMTP id t4so4654423vkb.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 03:52:26 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 9 Feb 2018 12:52:03 +0100
Message-ID: <CA+7wUswUir9cHEyvdT8vc+tvSxrcsoY8da+CpqG6kpc4oMj9Wg@mail.gmail.com>
Subject: powerpc-linux-gnu-ld: cannot open linker script file
 arch/powerpc/boot/zImage.coff.lds: No such file or directory
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

Is anyone using O= output directory option ?

It seems that git/master is failing:

$ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
$ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
(...)
Entry Point:  00b001e8
  DTC     arch/powerpc/boot/asp834x-redboot.dtb
  WRAP    arch/powerpc/boot/dtbImage.asp834x-redboot
INFO: Uncompressed kernel (size 0xa51720) overlaps the address of the
wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0xb00000)
  WRAP    arch/powerpc/boot/zImage.coff
powerpc-linux-gnu-ld: cannot open linker script file
arch/powerpc/boot/zImage.coff.lds: No such file or directory
../arch/powerpc/boot/Makefile:375: recipe for target
'arch/powerpc/boot/zImage.coff' failed
make[2]: *** [arch/powerpc/boot/zImage.coff] Error 1
rm arch/powerpc/boot/pq2fads.dtb arch/powerpc/boot/mpc836x_mds.dtb
arch/powerpc/boot/mpc832x_mds.dtb arch/powerpc/boot/mpc832x_rdb.dtb
arch/powerpc/boot/mpc834x_mds.dtb
arch/powerpc/boot/asp834x-redboot.dtb arch/powerpc/boot/mpc8272ads.dtb
arch/powerpc/boot/mpc8349emitx.dtb
arch/powerpc/boot/mpc8349emitxgp.dtb arch/powerpc/boot/ep8248e.dtb
arch/powerpc/Makefile:291: recipe for target 'zImage' failed
make[1]: *** [zImage] Error 2
