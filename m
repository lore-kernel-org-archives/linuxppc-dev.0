Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp13.wanadoo.fr (smtp13.wanadoo.fr [193.252.22.54])
	by ozlabs.org (Postfix) with ESMTP id 02D1B688DC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2006 22:06:34 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1307.wanadoo.fr (SMTP Server) with ESMTP id 2791A700031B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2006 12:06:31 +0100 (CET)
Date: Thu, 5 Jan 2006 12:05:23 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20060105110523.GA21982@localhost.localdomain>
References: <E1EtnU9-0008HI-I0@spohr.debian.org>
	<20051230171705.32043.38767.reportbug@sengor.ath.cx>
	<handler.345424.D345424.113629990832428.notifdone@bugs.debian.org>
	<43BCFA15.5070304@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43BCFA15.5070304@gmx.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to build the zImage.prep was Re: Bug#345424 acknowledged by
	developer (Bug#345424: fixed in linux-2.6 2.6.15-1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 05, 2006 at 11:51:01AM +0100, Sebastian Heutling wrote:
> Hi Sven,
> 
> maybe I'm just stupid - but I am not able to get an image built that can 

No, you just fail to read the manual :)

please : man mkvmlinuz :)

mkvmlinuz allows to build the zImage.prep from the vmlinux outside of the
kernel build process, which is what we are doing, otherwise the zImage.prep
may indeed be the way to handle this.

> be netbooted or put into the prep-bootloader partition. Looking at the 
> sources I wonder how you do it for the debian linux-images-* as the only 
> Makefile where it seems to generate a "zImage.prep" automagically is in 
> arch/ppc/boot/simple/Makefile. But that doesn't work, I guess, because 
> CONFIG_PPC_PREP doesn't exist anymore (at least I couldn't find it in 
> "menuconfig" or in the ".config" file).

Should work, i booted 2.6.14 on my powerstack II, didn't try 2.6.15 yet, but
will this WE.

> Before trying to build a kernel myself I tried the debian linux binary 
> image. An image for powerpc is not there yet so I used rc7. I netbooted 
> "/boot/vmlinuz-2.6.15-rc7-powerpc" and the result was that I got a lot 
> of output saying that there is something wrong. I assume the output was 
> from the firmware because the kernel usually doesn't report an endless 
> list of errors saying something about "stack exception" every now and 
> then and mostly printing zeros followed by a new line character.

Mmm, upstream may have broken prep on 2.6.15, i have to say i didn't test it,
will have a look this WE, ok ? 

> After that I copied the config from that kernel, downloaded the debian 
> sources of 2.6.15, enabled ISA and some alsa ISA sound drivers and run 
> into the trouble above.

Mmm, i am leaving for two days now, but i will have a look afterward.

Friendly,

Sven Luther
