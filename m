Message-ID: <39EF2C2B.D24DCE15@emc.com>
Date: Thu, 19 Oct 2000 13:15:23 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
To: "Tod E. Kurt" <tod@blastoff.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_read_config_byte in Hardhat CDK1.2 for powerpc
References: <Pine.LNX.4.21.0010171929100.19158-100000@gemini.home.net> <39EDD92F.BEC83BEB@emc.com> <39EDE34C.92EF5699@blastoff.com> <39EDE44B.255E686C@blastoff.com> <39EE1212.97CA8E71@emc.com> <39EE147B.B79A2837@blastoff.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Tod E. Kurt" wrote:

> Zhaobin Zhu wrote:
> >
> > Hi,
> >
> > Anybody knows where the function "pci_read_config_byte(..)" is defined ?
>
> Again, use 'grep' in '/usr/include/linux/*.h'.
>
> I did that and found it in '/usr/include/linux/pci.h'.

Yes,  pci_read_config_byte(..) is declared in include/linux/pci.h, but I
can't find
its C source anywhere. I do find it in System.map.

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
