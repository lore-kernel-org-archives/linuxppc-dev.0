Return-Path: <jhahn@bcfsemi.com>
Received: from raptor.bcfsemi.com (adsl-75-52-244-172.dsl.pltn13.sbcglobal.net
	[75.52.244.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD4B5DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 12:52:56 +1000 (EST)
Received: from jhahnPC ([192.168.0.121]) (authenticated bits=0)
	by raptor.bcfsemi.com (8.13.8/8.13.8) with ESMTP id l9M2qdJH016192
	for <linuxppc-embedded@ozlabs.org>; Sun, 21 Oct 2007 19:52:40 -0700
From: "John Hahn" <jhahn@bcfsemi.com>
To: <linuxppc-embedded@ozlabs.org>
References: <13290652.post@talk.nabble.com>	<fa686aa40710190704j18feabf2geb417d554ebb11c@mail.gmail.com>	<13300089.post@talk.nabble.com>
	<fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
In-Reply-To: <fa686aa40710191120w209b62a0l4f71e528e5f1a1b3@mail.gmail.com>
Subject: RE: SystemACE driver problem
Date: Sun, 21 Oct 2007 19:52:32 -0700
Message-ID: <001a01c81456$985b6a90$c9123fb0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant

Regarding your comment about the new xsysace.c driver vs. the old Xilinx
one, is that chosen at the kernel config time ? 

i.e.
cp arch/ppc/configs/ml403_defconfig
make ARCH=ppc CROSS_COMPILE=/opt/eldk4.1/usr/bin/ppc_4xx- oldconfig

...
Xilinx SystemACE support (XILINX_SYSACE) [N/m/y/?] (NEW) y
Xilinx SystemACE support (old driver) (XILINX_SYSACE_OLD) [N/m/y/?] (NEW) N

I am also about build and test with the 2.6.23-rc2 same source. Just wanted
to be sure I am choosing the right driver for the ml403 reference design
bits from Xilinx.

Thanks

John Hahn
BCF Semiconductor
---

P.S. Sorry for taking the thread off on a slight tangent ...

> From: Grant Likely
> Sent: Friday, October 19, 2007 11:21 AM
> 
... <snip>
>
> I don't know about the old xilinx supplied sysace driver, but the new
> xsysace.c driver is robust enough to work around missed interrupts.  I
> don't know of any other problems with the opb_sysace IP core.
> 
> Cheers,
> g.
> 
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
