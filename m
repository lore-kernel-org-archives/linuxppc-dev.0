Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f18.google.com (mail-bw0-f18.google.com
	[209.85.218.18]) by ozlabs.org (Postfix) with ESMTP id 4B5BCDDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 04:32:49 +1100 (EST)
Received: by bwz11 with SMTP id 11so1532156bwz.16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 09:32:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <497606D1.9090903@freescale.com>
References: <496F318D.6010302@denx.de>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
	<8cad0aa0901200905y642f1a39qc8c52a076edbd123@mail.gmail.com>
	<497606D1.9090903@freescale.com>
Date: Tue, 20 Jan 2009 18:32:22 +0100
Message-ID: <8cad0aa0901200932g5e6581abk7b0a142046c8341d@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/1/20 Scott Wood <scottwood@freescale.com>:
> Jean-Michel Hautbois wrote:
>>
>> It is *a lot* better !
>> I am finishing into a kernel panic, but it is a normal thing (bad
>> initramfs).
>>
>> Well, that was using the cuImage. When I try to use the uImage and the
>> FDT file, I am stopped here:
>>  Uncompressing Kernel Image ... OK
>>   Loading Ramdisk to 039d7000, end 03b7d996 ... OK
>>   Loading Device Tree to 007fa000, end 007fffff ... OK
>
> The early debug address is probably different when not using cuImage; you'll
> need to set it to wherever u-boot puts the transmit descriptor.
>
> -Scott
>

OK... And is there anywhere a description of how I can do that :s.
JM
