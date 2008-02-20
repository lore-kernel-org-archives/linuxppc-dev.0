Return-Path: <Dag.K.Rognlien@sintef.no>
Received: from smtpb.sintef.no (smtpb.sintef.no [129.241.253.24])
	by ozlabs.org (Postfix) with ESMTP id C64C7DDF72
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 20:50:38 +1100 (EST)
Received: from sintefav1.sintef.no (sintefav1.sintef.no [129.241.253.14])
	by smtpb.sintef.no (Postfix) with ESMTP id DFB27727D5
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:50:34 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: Build fails for adder875 redboot on Linux-2.6.25-rc2
Date: Wed, 20 Feb 2008 10:50:07 +0100
Message-ID: <39417DF3286A66428FA558987839F44F03FC9189@SINTEFXCH01.sintef.no>
In-Reply-To: <mailman.658.1203499779.17968.linuxppc-dev@ozlabs.org>
References: <mailman.658.1203499779.17968.linuxppc-dev@ozlabs.org>
From: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After the change to build images for several dts files the redboot image
failes to "wrap".

--
  WRAP    arch/powerpc/boot/cuImage.adder875-uboot
DTC: dts->dtb  on file ".../arch/powerpc/boot/dts/adder875-uboot.dts"
Image Name:   Linux-2.6.25-rc2-00359-g101142c
Created:      Wed Feb 20 10:38:21 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1053933 Bytes =3D 1029.23 kB =3D 1.01 MB
Load Address: 0x00400000
Entry Point:  0x00400554
  WRAP    arch/powerpc/boot/zImage-dtb.adder875-redboot
DTC: dts->dtb  on file ".../arch/powerpc/boot/dts/adder875-redboot.dts"
ppc_8xx-ld: arch/powerpc/boot/adder875-redboot.o: No such file: No such
file or directory
make[1]: *** [arch/powerpc/boot/zImage-dtb.adder875-redboot] Error 1
make: *** [zImage] Error 2


Regards,
Dag K. W. Rognlien
Research Scientist
SINTEF ICT Communication Systems
