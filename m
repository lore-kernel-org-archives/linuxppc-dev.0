Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8C22C67A70
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 06:22:59 +1000 (EST)
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: IMAP_ADDR on PPC 8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 May 2006 13:14:39 EDT."
	<1147194879.2200.41.camel@excalibur.timesys.com>
Date: Tue, 09 May 2006 22:22:57 +0200
Sender: wd@denx.de
Message-Id: <20060509202257.551DF352B2A@atlas.denx.de>
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

In message <1147194879.2200.41.camel@excalibur.timesys.com> you wrote:
> 
> Thanks again for the advice.  Interestingly, I gave the wrong address
> above.  It wasn't 0x22000000, it was 0x02200000 (i.e. even lower!).  And
> yet with the "io_remap()'ed global variable" patch, 2.6.11.7 does indeed
> work on this board with this U-Boot....  Perhaps this works because this
> particular board only has 8MiB of RAM....

It does not work. It will certainly crash as soon as you start a  few
user space applications.

> Bottom line: I'm wondering what the Linux PPC community thinks is the
> correct long term solution to these discrepancies.  Should we the
> community declare "Freescale U-Boots are considered harmful; never use
> them; always use the official U-Boot sources" ???

Indeed it would be nice if Freescale worked more  directly  with  the
community.

> Or should we create a kernel mechanism to automatically adapt to the
> different U-Boot flavors?

No, of course not. U-Boot is just one boot  loader,  there  are  many
others, and the kernel hast to stay independent.

And it is definitely not the kernel's fault if the boot  loader  sets
up a braindamaged memory map.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As in certain cults it is possible to kill a process if you know  its
true name.                      -- Ken Thompson and Dennis M. Ritchie
