Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 47C17681C2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 07:30:58 +1100 (EST)
To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 20 Nov 2005 10:58:26 PST."
	<61cc712d0511201058p367df361i7e46591336918712@mail.gmail.com>
Date: Sun, 20 Nov 2005 21:30:56 +0100
Sender: wd@denx.de
Message-Id: <20051120203056.11EAB353F54@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Memtest-SDRAM 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <61cc712d0511201058p367df361i7e46591336918712@mail.gmail.com> you wrote:
>
> > A simple test is: if Linux is running  without  problems  under  load
> > than there are no problems with your SDRAM.
> 
> Yes, but determining the proper load to test with can be tricky. 

Ummm.. I disagree. Avtually it's pretty simple. Boot the system  with
root  file  system  mounted  over  NFS.  The  compile  a Linux kernel
natively on the board. This is doing all you want: stressing  network
(lots  of  DMA),  stressing  the memory (lots of context switches and
heavy RAM use), etc. If your system survives this,  you  can  be  98%
sure that it will pass any other test as well.

> E.g., I had a subtle memory timing issue that only turned up under
> very peculiar circumstances under linux; this was very difficult to

Of course there are really weird cases,  but  fortunaltey  these  are
rare exceptions.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Committee, n.:  A group of men who individually can do nothing but as
a group decide that nothing can be done.                 - Fred Allen
