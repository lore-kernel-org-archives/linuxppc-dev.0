Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f17.google.com (mail-bw0-f17.google.com
	[209.85.218.17]) by ozlabs.org (Postfix) with ESMTP id A4DFCDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 04:07:58 +1100 (EST)
Received: by bwz10 with SMTP id 10so597287bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 09:07:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090120163155.GA8978@ld0162-tx32.am.freescale.net>
References: <496F318D.6010302@denx.de> <496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
Date: Tue, 20 Jan 2009 18:05:56 +0100
Message-ID: <8cad0aa0901200905y642f1a39qc8c52a076edbd123@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
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
> On Tue, Jan 20, 2009 at 11:56:58AM +0100, Jean-Michel Hautbois wrote:
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 162=
56
>> Kernel command line: root=3D/dev/ram rw
>> PID hash table entries: 256 (order: 8, 1024 bytes)
>> time_init: decrementer frequency =3D 25.000000 MHz
>> time_init: processor frequency   =3D 400.000000 MHz
>> clocksource: timebase mult[a000000] shift[22] registered
>> clockevent: decrementer mult[666] sh=EF=BF=BD
>
> That looks like something is failing when the real (as opposed to early
> debug) serial driver starts.  Try commenting out the call to cpm_setbrg
> in drivers/serial/cpm_uart/cpm_uart_cpm2.h; if that makes a difference,
> there's something wrong with the brg node in the device tree.
>
> -Scott
>
It is *a lot* better !
I am finishing into a kernel panic, but it is a normal thing (bad initramfs=
).

Well, that was using the cuImage. When I try to use the uImage and the
FDT file, I am stopped here:
  Uncompressing Kernel Image ... OK
   Loading Ramdisk to 039d7000, end 03b7d996 ... OK
   Loading Device Tree to 007fa000, end 007fffff ... OK

JM
