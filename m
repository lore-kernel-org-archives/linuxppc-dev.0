To: "Dejan Jovanovic" <dejanj@erlangtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260 serial on SCC support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Oct 2002 14:13:09 CDT."
             <00c001c279ff$0f8b6450$db00000a@dejanj>
Date: Tue, 22 Oct 2002 21:35:11 +0200
Message-Id: <20021022193516.CD94710148@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dejan,

in message <00c001c279ff$0f8b6450$db00000a@dejanj> you wrote:
>
> Is there support for serial console on SCC for MPC8260 in latest kernel
> distributions included in the ELDK or kernel version on the ftp://ftp.denx.de?

Yes, of course. See arch/ppc/8260_io/uart.c

> I am using custom MPC8260 board that has serial on SCC. Also I am using ELDK
> with the kernel version linux-2.4.4-2002-08-09.
> I cannot find the SCC serial support.

Please look again.

> I also saw posts with the patches for serial on SCC for MPC8260 and downloaded
> the patch but could not patch the kernel sucesfully.
>
> Is there some other patch for this or how can I include support for this in my
> kernel?

You don't need any patches when using our kernel; it has been  tested
with  up  to  6  x  serial  ports  (2  x SMC, 4 x SCC, for example on
MicroSys CR826/PM826 boards).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To the systems programmer,  users  and  applications  serve  only  to
provide a test load.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
