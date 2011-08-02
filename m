Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B1AADB71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 17:45:13 +1000 (EST)
Message-ID: <4E37AB04.9070409@windriver.com>
Date: Tue, 2 Aug 2011 15:45:08 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Fwd: MPC7410 Linux Kernel
References: <OFABB45B91.59E6539A-ONCA2578CC.006F5FB7-CA2578CC.0070CFA6@csc.com>	<CAFbQSaDaL0UaiY4r+u=a72mmsCHxs7O5Z82MESrXXcWj2tNvbQ@mail.gmail.com>	<OF7A7D0C50.273D2A69-ONCA2578CD.001B5783-CA2578CD.001D9FFE@csc.com>	<CAFbQSaAhXUrb1peJ2E3Kkp1gd16JSn9OjneO826q_aMz+yzAqg@mail.gmail.com>
	<CAFbQSaC6BkZj+a4=-9Q2Cyj7w=4y5QYM22kaK1O=Uz5KW9iiuQ@mail.gmail.com>
In-Reply-To: <CAFbQSaC6BkZj+a4=-9Q2Cyj7w=4y5QYM22kaK1O=Uz5KW9iiuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vineeth wrote:
> Hi,
> 
> We are trying to port  linux 2.6.38 on MPC7410 based board (This is a
> preparatory design by our customer)
> 
> System architecture is as follows,
> 
> MPC7410 <=> MPC107 <=> PCI_to_LOCAL(plx9052) <=> UART

MPCXXX should be compatible with TSIXXX. So you can refer to mpc7448_hpc2.

> 
> Previously we were using ppc architecture and we had some issues with
> page_init() functions; which may be because of our configuration.As we didnt
> get much support on ppc architecture we moved to powerpc.
> 
> Now we moved to powerpc architecture. We have some doubts on writing the dts
> file. Please find the dts file attached.
> 
> when we checked the legacy_serial.c file, we found that
> legacy_serial_parents not expecting a pci-local or a pci bridge as parent.
> is our understanding correct ? should we introduce a new pci parent in that
> structure ?

So you can understand this after refer to the file,
arch/powerpc/boot/dts/mpc7448hpc2.dts.

Tiejun

> 
>  We are confused about writing the ranges property of PCI node.we were
> referring booting_without_of doc but didnt get much info. Is there any file
> which gives better idea about the ranges property ?
> 
> Thanks
>  Vineeth
