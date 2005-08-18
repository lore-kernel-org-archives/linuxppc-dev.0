Return-Path: <kjoutwater@raytheon.com>
Received: from tus-gate4.raytheon.com (tus-gate4.raytheon.com [199.46.245.233])
	by ozlabs.org (Postfix) with ESMTP id 8726668079
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 04:13:24 +1000 (EST)
In-Reply-To: <43049D99.6090908@xilinx.com>
To: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF820ADBC7.FD07ABA9-ON07257061.00633C32-07257061.00641841@mck.us.ray.com>
Date: Thu, 18 Aug 2005 11:13:11 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Best kernel for Xilinx VirtexII Pro/PPC405 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter - 
Well, the good news is that it works, and works well.  In my humble 
opinion, supporting it would be pretty simple, but I completely understand 
why RHEL is the supported distribution.  I would much rather see effort 
put into polishing up EDK under Linux than in supporting every Linux 
distro out there.
For me, the bottom line was this: do I want to migrate all of other 
development activities from FC4 to RHEL for the sake of EDK, or try to run 
EDK under FC4?  I tried the latter approach, and now that the Jungo 
WinDriver v7.1 is out, parallel port debugging works by simply using 
WinDriver 7.1 and patching the Xilinx XPC4 parport driver.
I now have the kernel booting on a Memec 2VP50 eval board using U-Boot as 
the bootloader.  I used the linuxppc-2.4 kernel rsynced from MontaVista. 
That particular kernel did not have support for U-Boot but it did support 
the ML300 and a Memec 2VP40/2VP70 board.  I had to modify the kernel to 
accept a board description structure from U-Boot and I added a new board 
type for my custom hardware.
The approach I took was definitely the "roll your own approach", but then 
again I've done this (Linux board ports) a couple times and I know U-Boot 
well.
Keith

Peter Ryser <peter.ryser@xilinx.com> wrote on 08/18/2005 07:39:21 AM:

> 
> > I am running all of my development tools (EDK, ISE, ELDK, etc...) 
under 
> >Fedora Core 4, so I am looking for a publicly accessible kernel source 
> >tree that best supports the PPC405 in the Virtex II Pro.
> >
> Keep in mind that EDK and ISE are not "officially" supported on FC4. 
> Anyway, with EDK, ISE, and ELDK you seem to have all that is needed to 
> get started with Linux on Virtex-II Pro and Virtex-4.
> 
> - Peter
> 
>
