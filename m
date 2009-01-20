Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8C0CDDF26
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 04:17:30 +1100 (EST)
Message-ID: <497606D1.9090903@freescale.com>
Date: Tue, 20 Jan 2009 11:16:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
References: <496F318D.6010302@denx.de> <496F4760.1010007@denx.de>	
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>	
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>	
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>	
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>	
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>	
	<4970CBA9.60809@freescale.com>	
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>	
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
	<8cad0aa0901200905y642f1a39qc8c52a076edbd123@mail.gmail.com>
In-Reply-To: <8cad0aa0901200905y642f1a39qc8c52a076edbd123@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Michel Hautbois wrote:
> It is *a lot* better !
> I am finishing into a kernel panic, but it is a normal thing (bad initramfs).
> 
> Well, that was using the cuImage. When I try to use the uImage and the
> FDT file, I am stopped here:
>   Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 039d7000, end 03b7d996 ... OK
>    Loading Device Tree to 007fa000, end 007fffff ... OK

The early debug address is probably different when not using cuImage; 
you'll need to set it to wherever u-boot puts the transmit descriptor.

-Scott
