Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CB1DDDEBB
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 06:58:02 +1000 (EST)
Message-ID: <46C368D1.7000403@freescale.com>
Date: Wed, 15 Aug 2007 15:57:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: mike zheng <mail4mz@gmail.com>
Subject: Re: System crash on boot_e500.S
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>	<1187124014.32650.80.camel@ld0161-tx32>	<5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>	<20070815160254.GA9049@ld0162-tx32.am.freescale.net>	<A9A39446-A8B0-44D7-ABF4-E9918FCC2843@kernel.crashing.org>	<16A6A248-880E-483A-AFDD-2A225F4B6864@freescale.com>
	<5c9cd53b0708151353u67e10e03lf12c3971e4f3d63@mail.gmail.com>
In-Reply-To: <5c9cd53b0708151353u67e10e03lf12c3971e4f3d63@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mike zheng wrote:
> Unfortunately, all the applications are running on 2.4 kernel. I can not
> just throw the 2.4 kernel.

And in what way does 2.6 break these applications?

> I took the some core specific code from
> ppc.bkbits.net, such as head_e500.S and mpc85xx_cds_common.c. I assume the
> image should work on the 8548 CDS board, or at least for the bootup. I shall
> able to have the serial port working in platform_init(). However , the
> code stops in the head_e500.S. This does not make any sense. Please correct
> me if I am wrong.

Of course it makes sense -- you can't just go around ripping random 
files from a codebase, sticking them in a version from several years 
earlier, and expecting it to "just work".

> Any suggest or comment is welcome, I am struggling with this issue for
> almost one week...... :-(

How long would you have struggled with getting your applications running 
on a more recent kernel instead?

-Scott
