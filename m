Message-Id: <200003232005.VAA05535@denx.local.net>
To: christof <xfr@freenet.de>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel executing from flash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Mar 2000 16:14:30 +0100."
             <1314024740.953824470340.JavaMail.wwwrun@moe.freenet.de>
Date: Thu, 23 Mar 2000 21:05:40 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1314024740.953824470340.JavaMail.wwwrun@moe.freenet.de> you wrote:
>
> all Linux I know will be copied during startup from Harddisk, NFS or Flash to RAM and will be executed there.
> Is there a possibility for smaller systems to run the
> kernel directly from flash memory as other embedded os's do? Did somebody try this or is it totaly impossible?

It may be possible, but usually it does not make much sense - to  run
the  kernel directly from FLASH you must store an uncompressed kernel
image there, so you need  more  FLASH.  Given  the  price  difference
between  FLASH  and  DRAM  memory is often cheaper to uncompress into
RAM, and run from RAM.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only person who always got his work done by Friday
                                                 was Robinson Crusoe.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
