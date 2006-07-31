Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1636867B56
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 23:39:39 +1000 (EST)
Date: Mon, 31 Jul 2006 17:39:59 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Demke Torsten-atd012" <torsten.demke@motorola.com>
Subject: Re: Compilation error in fsl_soc.c
Message-ID: <20060731173959.03f57dd4@vitb.ru.mvista.com>
In-Reply-To: <67194FEE6056B947B4EF756C9E497A2EA198F8@zuk35exm60.ds.mot.com>
References: <67194FEE6056B947B4EF756C9E497A2EA198F8@zuk35exm60.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 31 Jul 2006 08:37:56 +0100
"Demke Torsten-atd012" <torsten.demke@motorola.com> wrote:

> Hi all,
> 
> with a recent versions from Paulus merge-tree the compilation
> of MPC85xx CDS failed with following output:
> ...
>   LD      arch/powerpc/lib/built-in.o
>   CC      arch/powerpc/sysdev/mpic.o
>   CC      arch/powerpc/sysdev/indirect_pci.o
>   AS      arch/powerpc/sysdev/dcr.o
>   CC      arch/powerpc/sysdev/fsl_soc.o
> arch/powerpc/sysdev/fsl_soc.c: In function 'gfar_mdio_of_init':
> arch/powerpc/sysdev/fsl_soc.c:88: error: 'struct device_node' has no
> member name d 'n_intrs'
> arch/powerpc/sysdev/fsl_soc.c:91: error: 'struct device_node' has no
> member name d 'intrs'
> arch/powerpc/sysdev/fsl_soc.c: In function 'gfar_of_init':
> arch/powerpc/sysdev/fsl_soc.c:142: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:143: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:153: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:154: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:158: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:159: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:165: error: 'struct device_node' has no
> member nam ed 'n_intrs'
> arch/powerpc/sysdev/fsl_soc.c: In function 'fsl_i2c_of_init':
> arch/powerpc/sysdev/fsl_soc.c:254: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:255: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c: In function 'fsl_usb_of_init':
> arch/powerpc/sysdev/fsl_soc.c:391: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:392: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:440: error: 'struct device_node' has no
> member nam ed 'intrs'
> arch/powerpc/sysdev/fsl_soc.c:441: error: 'struct device_node' has no
> member nam ed 'intrs'
> make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
> make: *** [arch/powerpc/sysdev] Error 2

No, since it is just going to be out.

I'll submit some patches addressing that this week...

-- 
Sincerely, 
Vitaly
