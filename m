Message-ID: <2F67A63DFFB1D31185D90090278CBB2D01679D7D@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
To: Zhaobin Zhu <zzhu@emc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Sandpoint/PPMC750 MPPMC7400
Date: Mon, 25 Sep 2000 10:14:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> -----Original Message-----
> From: Zhaobin Zhu [mailto:zzhu@emc.com]
> Sent: Friday, September 22, 2000 11:47 PM
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Sandpoint/PPMC750 MPPMC7400
> Hi,
>
> I has been trying to boot Hardhat (CDK1.2)linux kernel on
> Sandpoint/PPMC750. Everytime the boot gets stuck at
> .......
> >Uncompressing Linux...done.
> >Now booting the kernel
Do you use 2.3.16 kernel ? The kernel stops here may be caused by MMU_init,
please check the arch/ppc/kernel/head.S and arch/ppc/mm/init.c. (you can use
ppc_md.progress for printing messages)

>
> Also what COP-based debug tools are available for
> PPMC750/7400 on sandpoint.
> Somebody mentioned Arbitron and EST.
> Did anybody have experience with them and what you recommend ?
Here we have Arbitiron BDI2000, it is a little bit helpful but I think that
reading the kernel source is the most useful way, or you can try xmon.

Thanks,
Haitao Zhang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
