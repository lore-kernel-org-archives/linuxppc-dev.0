Message-ID: <39EF3BF3.19194E4A@emc.com>
Date: Thu, 19 Oct 2000 14:22:43 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_read_config_byte in Hardhat CDK1.2 for powerpc
References: <Pine.LNX.4.21.0010171929100.19158-100000@gemini.home.net> <39EDD92F.BEC83BEB@emc.com> <39EDE34C.92EF5699@blastoff.com> <39EDE44B.255E686C@blastoff.com> <39EE1212.97CA8E71@emc.com> <39EE147B.B79A2837@blastoff.com> <39EF2C2B.D24DCE15@emc.com> <39EF324F.B45B73FE@mvista.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> The definitions of pci_xxx_config_yyy and pcibios_xxx_config_yyy are hard to
> find.
>
> pci_xxx_config_yyy are defined by the PCI_OP() macro in drivers/pci/pci.c
> pcibios_xxx_config_yyy are defined by the PCI_OP() macro in
> drivers/pci/compat.c
>

Thanks, Mark.

Here is what I found:

pci_read_config_byte =  generic_pcibios_read_byte =
ppc_md.pcibios_read_config_byte = indirect_pcibios_read_config_byte
in arch/ppc/kernel/indirect_pci.c

--
 Zhaobin Zhu
 zzhu@emc.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
