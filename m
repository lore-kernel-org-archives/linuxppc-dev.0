Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 40718688DC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2006 21:51:03 +1100 (EST)
Message-ID: <43BCFA15.5070304@gmx.de>
Date: Thu, 05 Jan 2006 11:51:01 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: sven.luther@wanadoo.fr
References: <E1EtnU9-0008HI-I0@spohr.debian.org>
	<20051230171705.32043.38767.reportbug@sengor.ath.cx>
	<handler.345424.D345424.113629990832428.notifdone@bugs.debian.org>
In-Reply-To: <handler.345424.D345424.113629990832428.notifdone@bugs.debian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: How to build the zImage.prep was Re: Bug#345424 acknowledged
 by developer         (Bug#345424: fixed in linux-2.6 2.6.15-1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sven,

maybe I'm just stupid - but I am not able to get an image built that can 
be netbooted or put into the prep-bootloader partition. Looking at the 
sources I wonder how you do it for the debian linux-images-* as the only 
Makefile where it seems to generate a "zImage.prep" automagically is in 
arch/ppc/boot/simple/Makefile. But that doesn't work, I guess, because 
CONFIG_PPC_PREP doesn't exist anymore (at least I couldn't find it in 
"menuconfig" or in the ".config" file).

Before trying to build a kernel myself I tried the debian linux binary 
image. An image for powerpc is not there yet so I used rc7. I netbooted 
"/boot/vmlinuz-2.6.15-rc7-powerpc" and the result was that I got a lot 
of output saying that there is something wrong. I assume the output was 
from the firmware because the kernel usually doesn't report an endless 
list of errors saying something about "stack exception" every now and 
then and mostly printing zeros followed by a new line character.

After that I copied the config from that kernel, downloaded the debian 
sources of 2.6.15, enabled ISA and some alsa ISA sound drivers and run 
into the trouble above.


Sebastian


Debian Bug Tracking System wrote:
> This is an automatic notification regarding your Bug report
> #345424: linux-source-2.6.14: Missing IDE IRQ for PReP Utah (PowerstackII Pro4000),
> which was filed against the linux-source-2.6.14 package.
> 
> It has been closed by one of the developers, namely
> Sven Luther <luther@debian.org>.
> 
> Their explanation is attached below.  If this explanation is
> unsatisfactory and you have not received a better one in a separate
> message then please contact the developer, by replying to this email.
> 
> Debian bug tracking system administrator
> (administrator, Debian Bugs database)
> 
