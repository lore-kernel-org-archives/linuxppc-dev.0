Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B892567B8F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 09:00:10 +1000 (EST)
To: Adrian <adrian@it-live.co.uk>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPChameleonEVB Newbie question 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Oct 2006 17:24:34 +0200."
	<010001c6ed49$aa8ab390$3a0da8c0@adrianlaptop>
Date: Thu, 12 Oct 2006 01:00:08 +0200
Sender: wd@denx.de
Message-Id: <20061011230008.74BA7353DA0@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Adrian,

in message <010001c6ed49$aa8ab390$3a0da8c0@adrianlaptop> you wrote:
> 
> I have a PPChameleonEVB board running a 405EP processor.

DAVE has a lot of pretty detailed application  notes.  Make  sure  to
read their docs.

> I have tried many things, and can now boot Linux 2.6.15 on the board using 
> an NFS share as both root fs and swap.

Swap over NFS? Grrghh... 

> When I try to compile & install the kernel modules on the board, i get an 
> message about perl and then it errors.

Why don't you just use the cross tools?

> 1) Kernel version/Linux distroof the i386 PC used for the cross-compiling.

Should not matter much.

> 2) ELDK version and if there are any patches needed.

For a 2.6 kernel tree you need ELDK 4.0.

> 2) Perl version (or how to stop the Kernel build using perl)

Use the cross tools. It's much faster anyway.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
He had quite a powerful intellect, but it  was  as  powerful  like  a
locomotive,  and  ran on rails and was therefore almost impossible to
steer.                          - Terry Pratchett, _Lords and Ladies_
