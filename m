Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAB0067BB4
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Sep 2006 02:54:10 +1000 (EST)
Message-Id: <200609031642.k83GgOuo089969@penguin.ncube.com>
To: Zoltan HERPAI <wigyori@uid0.hu>
From: Michael Galassi <mgalassi@c-cor.com>
Subject: Re: Serial problem with MPC8241-based board 
In-reply-to: Your message of "Sun, 03 Sep 2006 17:36:47 +0200."
	<44FAF68F.1080206@uid0.hu>
Date: Sun, 03 Sep 2006 09:42:24 -0700
Sender: mgalassi@c-cor.com
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Michael Galassi <mgalassi@c-cor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I've recently acquired an Allnet 6250 NAS, which has an MPC8241-based 
>board. Since its GPL tarball is not available fully, I began to build a 
>toolchain based on gcc-3.4.6 and binutils-2.16.1, and an up-to-date 
>kernel for it. PPCboot states that this is a Sandpoint 8241 Unity board, 
>so the platforms/sandpoint.* was chosen as a starting point, however, 
>after rewriting the irq and ioport values in sandpoint.h to the ones 
>(irq 137, ioport 0x80004500), no output came out of the serial port. 
>After a few days of tweaking around with variables is sandpoint.h, a 
>google session revealed that this board is 99% the same as the Buffalo 
>Linkstation's is, which has a 2.6.x port also, but those kernels are 
>also failing to display any output.
>Can anyone shed some light on what points should I check and what may I 
>have done wrong?

I've recently spent a bunch of time chasing after display issues related
to the goofy way Linux handles consoles early on.  Try removing console=
from your boot arguments and see where that puts you.

-michael
