Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id AEEC82C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 03:55:49 +1000 (EST)
Received: from jacques.telenet-ops.be (jacques.telenet-ops.be [195.130.132.50])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 3CF9935FE2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 19:55:12 +0200 (CEST)
Date: Tue, 27 Aug 2013 19:55:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.11-rc7
In-Reply-To: <alpine.DEB.2.02.1308271951240.13016@ayla.of.borg>
Message-ID: <alpine.DEB.2.02.1308271954100.13120@ayla.of.borg>
References: <alpine.DEB.2.02.1308271951240.13016@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Aug 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.11-rc7 to v3.11-rc6[3], the summaries are:
>   - build errors: +15/-9

  + /scratch/kisskb/src/arch/powerpc/sysdev/mpic.c: error: case label does not reduce to an integer constant:  => 892:9, 904:9, 900:9, 896:9
  + /scratch/kisskb/src/drivers/net/ethernet/amd/lance.c: error: implicit declaration of function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]:  => 1204:6
  + /scratch/kisskb/src/drivers/net/ethernet/amd/lance.c: error: implicit declaration of function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:  => 575:2
  + /scratch/kisskb/src/drivers/net/ethernet/amd/ni65.c: error: implicit declaration of function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]:  => 756:4
  + /scratch/kisskb/src/drivers/net/ethernet/amd/ni65.c: error: implicit declaration of function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:  => 586:2
  + /scratch/kisskb/src/drivers/net/ethernet/cirrus/cs89x0.c: error: implicit declaration of function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:  => 896:1
  + /scratch/kisskb/src/drivers/scsi/aha1542.c: error: implicit declaration of function 'isa_page_to_bus' [-Werror=implicit-function-declaration]:  => 674:4
  + /scratch/kisskb/src/drivers/scsi/aha1542.c: error: implicit declaration of function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]:  => 477:3
  + /scratch/kisskb/src/drivers/scsi/wd7000.c: error: implicit declaration of function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]:  => 1055:2
  + /scratch/kisskb/src/drivers/scsi/wd7000.c: error: implicit declaration of function 'isa_page_to_bus' [-Werror=implicit-function-declaration]:  => 1121:4
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

  + /scratch/kisskb/src/drivers/usb/host/ohci-pci.c: error: 'ohci_resume' undeclared (first use in this function):  => 310:34
  + /scratch/kisskb/src/drivers/usb/host/ohci-pci.c: error: 'ohci_suspend' undeclared (first use in this function):  => 309:35

20 configs suppressed ;-)

> [1] http://kisskb.ellerman.id.au/kisskb/head/6579/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6556/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
