Message-ID: <39F5B5B0.F31E30A1@LynuxWorks.com>
Date: Tue, 24 Oct 2000 09:15:44 -0700
From: Vitaly Luban <vluban@LynuxWorks.COM>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Is the difference in IRQ maps between 2.4/2.2 intentional?
References: <14837.11341.207379.903189@argo.linuxcare.com.au> <20001024221817.A24315@suse.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi folks !

Maybe anybody will enlighten me, is the difference between
IRQ maps initialization (arch/ppc/kernel/prep_pci.c) in 2.4
and 2.2 intentional or not? The difference is in that for

Mesquite_pci_IRQ_map,
Sitka_pci_IRQ_map,
MTX_pci_IRQ_map,
MTXplus_pci_IRQ_map and
Genesis2_pci_IRQ_map

some fields have been initialised for 2.2.16 and zero for 2.4.

Thanks,
    Vitaly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
