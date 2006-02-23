Return-Path: <tnt@blacksnow.net>
Received: from misato.blacksnow.net (host-212-68-202-235.brutele.be
	[212.68.202.235]) by ozlabs.org (Postfix) with ESMTP id 47829679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Feb 2006 22:29:32 +1100 (EST)
Message-ID: <56320.130.104.237.63.1140689291.squirrel@webmail.blacksnow.net>
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.
	sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
	<43FD6669.9090405@246tNt.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
Date: Thu, 23 Feb 2006 11:08:11 +0100 (CET)
Subject: RE: boot failure on lite5200b board
From: tnt@blacksnow.net
To: "#LI JIANGGAN#" <lijianggan@pmail.ntu.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: #WONG CHEE KHIN# <wong0162@ntu.edu.sg>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Thank you José María and Andrey for your advices, however the problem
> remains. I've tried setting the console (though I remember that our
> previous lite5200 board was working fine on kernel 2.4 without setting the
> console); meantime,

In 2.4 you didn't need to set the console. On 2.6 we don't use the
standard ttyS0 naming for the PSC because it causes conflict when another
serial card was inserted (in a pcmcia slot for ex.).


> I've set the booting image to 0x500000; I have also
> tried using the kernel image come together with the BSP, it's always the
> same error.

> Load address: 0x100000
In the log you sent, you still use a low load address ...

> Sylvain, I've actually using your kernel source, the compiled image is
> around 700k (compared to the 1.4M image from the BSP), but it doesn't
> solve the problem. So I presume that the problem is lying somewhere else.

Do you have a hardware debugger to see where it's stopping ?
I'm at work right now, but I'll have a look when I get home.


    Sylvain
