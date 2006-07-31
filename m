Return-Path: <torsten.demke@motorola.com>
Received: from motgate2.mot.com (motgate2.mot.com [144.189.100.101])
	by ozlabs.org (Postfix) with ESMTP id DEA1D67B56
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 17:38:08 +1000 (EST)
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate2.mot.com (8.12.11/Motorola) with ESMTP id k6V7bxDX023232
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 00:38:04 -0700 (MST)
Received: from zuk35exm60.ds.mot.com (zuk35exm60.ea.mot.com [10.178.1.39])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id k6V7bwhV012718
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 02:37:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Compilation error in fsl_soc.c
Date: Mon, 31 Jul 2006 08:37:56 +0100
Message-ID: <67194FEE6056B947B4EF756C9E497A2EA198F8@zuk35exm60.ds.mot.com>
From: "Demke Torsten-atd012" <torsten.demke@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

with a recent versions from Paulus merge-tree the compilation
of MPC85xx CDS failed with following output:
...
  LD      arch/powerpc/lib/built-in.o
  CC      arch/powerpc/sysdev/mpic.o
  CC      arch/powerpc/sysdev/indirect_pci.o
  AS      arch/powerpc/sysdev/dcr.o
  CC      arch/powerpc/sysdev/fsl_soc.o
arch/powerpc/sysdev/fsl_soc.c: In function 'gfar_mdio_of_init':
arch/powerpc/sysdev/fsl_soc.c:88: error: 'struct device_node' has no
member name d 'n_intrs'
arch/powerpc/sysdev/fsl_soc.c:91: error: 'struct device_node' has no
member name d 'intrs'
arch/powerpc/sysdev/fsl_soc.c: In function 'gfar_of_init':
arch/powerpc/sysdev/fsl_soc.c:142: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:143: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:153: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:154: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:158: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:159: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:165: error: 'struct device_node' has no
member nam ed 'n_intrs'
arch/powerpc/sysdev/fsl_soc.c: In function 'fsl_i2c_of_init':
arch/powerpc/sysdev/fsl_soc.c:254: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:255: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c: In function 'fsl_usb_of_init':
arch/powerpc/sysdev/fsl_soc.c:391: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:392: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:440: error: 'struct device_node' has no
member nam ed 'intrs'
arch/powerpc/sysdev/fsl_soc.c:441: error: 'struct device_node' has no
member nam ed 'intrs'
make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

Did I missed a patch?

Regards,
Torsten
