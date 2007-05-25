Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 74F5EDDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 18:28:56 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 5ABD124B194
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 08:14:44 +0000 (UTC)
Received: from ibook.aepfle.de (DSL01.83.171.168.82.ip-pool.NEFkom.net
	[83.171.168.82])
	by mail.mnet-online.de (Postfix) with ESMTP id B5EC790DB9
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:14:45 +0200 (CEST)
Date: Fri, 25 May 2007 10:14:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: arch/powerpc/boot/coff.o
Message-ID: <20070525081459.GA30239@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Does anyone happen to know where the arch/powerpc/boot/coff.o is
supposed to come from? Current Linus tree fails since a while with the
following commands.

tar xfz /mounts/mirror/kernel/v2.6/testing/linux-2.6.22-rc2.tar.gz
cd linux-2.6.22-rc2/
mkdir ../O
cp arch/powerpc/configs/pmac32_defconfig ../O/.config
make -kj42 O=../O menuconfig
make -kj42 O=../O 

  WRAP    arch/powerpc/boot/zImage.coff
ld: arch/powerpc/boot/coff.o: No such file: No such file or directory
nm: 'arch/powerpc/boot/zImage.coff': No such file
objdump: 'arch/powerpc/boot/zImage.coff': No such file
