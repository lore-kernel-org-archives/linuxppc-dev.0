To: Alireza Sadri <arsadri@yahoo.ca>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: UPM driver of MPC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 30 Jun 2004 06:37:52 PDT."
             <20040630133752.81669.qmail@web12826.mail.yahoo.com>
Date: Wed, 30 Jun 2004 16:26:13 +0200
Message-Id: <20040630142618.01866C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Alireza Sadri,

in message <20040630133752.81669.qmail@web12826.mail.yahoo.com> you wrote:
>
> I am going to use UPM of my MPC8260; I need it for
> handling a burstable SRAM.

This is something that your boot loader needs to deal  with.  It  has
nothing to do with Linux as the Linux kernel does not care about such
low-level hardware intializations. Strictly speaking, your message is
off topic here.

> I am using Wind River SBCPOWERQUICCII board. So I

I'm pretty sure that this is not the official name of the  board,  or
is it? Maybe it's SBC8260?

> think I need the configured UPM driver to be run on my
> Linux.

There  are  no  Linux  drivers  that  deal  with  this  stuff;  while
technically being possible, it makes little sende. Usually this stuff
is done in your boot loader.

> Does ELDK have UPM initialization routines for my
> purpose? Can I use this machine in a service then?

Well, the ELDK includes the full source  code  of  U-Boot,  and  yes,
there is a configuration of U-Boot for the SBC8260 available.

> Can I have this driver for any other Linux, for
> example VxWorks BSP? Can I configure my driver and use
> it for SRAM?

First, this is not a driver. It  is  part  of  the  low-level  system
initialization.

Second, VxWorks is a proprietary operating system, and  not  "another
Linux".

Finally, you will have to check which boot loader you are  using  and
which  sort  of  initializations are already being done there for the
SBC8260 board, and eventually add what  might  be  missing  for  your
specific  setup.  But this is off topic here (feel free to ask futher
question on the u-boot-users mailing list - if you use U-Boot).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Without facts, the decision cannot be made logically. You  must  rely
on your human intuition.
	-- Spock, "Assignment: Earth", stardate unknown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
