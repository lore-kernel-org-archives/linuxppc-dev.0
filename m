Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep8.connect.com.au (fep8.mfe.bur.connect.com.au [203.63.86.8])
	by ozlabs.org (Postfix) with ESMTP id 34759684CE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 10:13:18 +1000 (EST)
Message-ID: <434B03A2.8060608@rftechnology.com.au>
Date: Tue, 11 Oct 2005 10:13:22 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20051010234614.1FE2A353D84@atlas.denx.de>
In-Reply-To: <20051010234614.1FE2A353D84@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Are you sure that your flash device name in Linux is just "0" ? 
I think you are right. I missed the point.

=> flinfo

Bank # 1: Sharp 28F016SC (16 Mbit, 32 x 64K)
   Size: 8 MB in 32 Sectors
   Sector Start Addresses:
     FF800000      FF840000      FF880000      FF8C0000      FF900000
     FF940000      FF980000      FF9C0000      FFA00000      FFA40000
     FFA80000      FFAC0000      FFB00000      FFB40000      FFB80000
     FFBC0000      FFC00000      FFC40000      FFC80000      FFCC0000
     FFD00000      FFD40000      FFD80000      FFDC0000      FFE00000
     FFE40000      FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO)
     FFF80000      FFFC0000

So I have
mtdparts=1:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

But problem remains...
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,1)
