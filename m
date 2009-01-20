Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f18.google.com (mail-bw0-f18.google.com
	[209.85.218.18]) by ozlabs.org (Postfix) with ESMTP id 27D73DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 03:27:51 +1100 (EST)
Received: by bwz11 with SMTP id 11so1435225bwz.16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 08:27:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
Date: Tue, 20 Jan 2009 17:27:09 +0100
Message-ID: <8cad0aa0901200827o5f225ac9rfe2a13984e83d4d3@mail.gmail.com>
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

2009/1/20 Jean-Michel Hautbois <jhautbois@gmail.com>:
> OK, I just tried a cuImage and a ramdisk without a FDT. I am starting
> to boot, but it freezes.
[...]
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1625=
6
> Kernel command line: root=3D/dev/ram rw
> PID hash table entries: 256 (order: 8, 1024 bytes)
> time_init: decrementer frequency =3D 25.000000 MHz
> time_init: processor frequency   =3D 400.000000 MHz
> clocksource: timebase mult[a000000] shift[22] registered
> clockevent: decrementer mult[666] sh=EF=BF=BD
>

Having a look at the arch/powerpc/kernel/time.c file, where I am
getting halted, it seems that the kernel reads the CPU frequency. Here
is my question: My board has an OSC that is 100MHz (and not 400MHz !).
I think this could be my explanation, but I can't see how I could
solve this problem...

Has anyone an idea ?
Thx & Regards,
JM
