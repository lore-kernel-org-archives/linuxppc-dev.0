Message-ID: <39EF340B.8F309605@blastoff.com>
Date: Thu, 19 Oct 2000 10:48:59 -0700
From: "Tod E. Kurt" <tod@blastoff.com>
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_read_config_byte in Hardhat CDK1.2 for powerpc
References: <Pine.LNX.4.21.0010171929100.19158-100000@gemini.home.net> <39EDD92F.BEC83BEB@emc.com> <39EDE34C.92EF5699@blastoff.com> <39EDE44B.255E686C@blastoff.com> <39EE1212.97CA8E71@emc.com> <39EE147B.B79A2837@blastoff.com> <39EF2C2B.D24DCE15@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhaobin Zhu wrote:
>
> "Tod E. Kurt" wrote:
>
> > Zhaobin Zhu wrote:
> > >
> > > Hi,
> > >
> > > Anybody knows where the function "pci_read_config_byte(..)" is defined ?
> >
> > Again, use 'grep' in '/usr/include/linux/*.h'.
> >
> > I did that and found it in '/usr/include/linux/pci.h'.
>
> Yes,  pci_read_config_byte(..) is declared in include/linux/pci.h, but I
> can't find
> its C source anywhere. I do find it in System.map.


As someone else mentioned, it (along with most all the other functions
declared in 'pci.h') is is '/usr/src/linux/drivers/pci/pci.c'.  It wraps
'pcibios_read_config_byte', which is defined in
'/usr/src/linux/arch/i386/kernel/bios32.c' for PCs and in various files
(depending on specific arch) in '/usr/src/linux/arch/ppc/kernel'.

-=tod

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
