Date: Tue, 24 Oct 2000 13:38:56 -0700
From: Matt Porter <mporter@mvista.com>
To: Vitaly Luban <vluban@LynuxWorks.COM>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the difference in IRQ maps between 2.4/2.2 intentional?
Message-ID: <20001024133856.A9366@cx258813-a.chnd1.az.home.com>
References: <14837.11341.207379.903189@argo.linuxcare.com.au> <20001024221817.A24315@suse.de> <39F5B5B0.F31E30A1@LynuxWorks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39F5B5B0.F31E30A1@LynuxWorks.com>; from vluban@LynuxWorks.COM on Tue, Oct 24, 2000 at 09:15:44AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 24, 2000 at 09:15:44AM -0700, Vitaly Luban wrote:
>
> Hi folks !
>
> Maybe anybody will enlighten me, is the difference between
> IRQ maps initialization (arch/ppc/kernel/prep_pci.c) in 2.4
> and 2.2 intentional or not? The difference is in that for
>
> Mesquite_pci_IRQ_map,
> Sitka_pci_IRQ_map,
> MTX_pci_IRQ_map,
> MTXplus_pci_IRQ_map and
> Genesis2_pci_IRQ_map
>
> some fields have been initialised for 2.2.16 and zero for 2.4.

Look at all of prep_pci.c and you'll see that many board specific
PCI changes were made in the linuxppc_2_2 tree that have not
yet been merged up to linuxppc_2_3.  It is in the plan, however.

The map changes are benign cruft from a set of changes I merged
in a long time ago.  It was a hack to place 0x1e value at the
PIB's IDSEL for some IDE fixups that aren't really necessary.

Now you know the whole story. :)

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
