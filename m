To: "Dustin Byford" <dustin@firein.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom mpc8240 student project (long) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Feb 2002 16:17:24 EST."
             <web-8690106@zipmail.com>
Date: Mon, 18 Feb 2002 22:44:09 +0100
Message-Id: <20020218214414.69EE4109E2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dustin,

in message <web-8690106@zipmail.com> you wrote:
>
> Thanks for your response.  I was hoping to use something I
>  build myself to do the BDM programming.  Something similar

If it was just for the hardware, you could just use the parallel port
adapter of the BDM4GDB project.

But this is just the hardware, and you still need the software part...

>  to what people are doing for the LART project with JFlash.
>   I understand a NDA is required for all the details about
>  the JTAG/COP port on the MPC8240 but all I really need
>  here is basic flash programming so I can bootstrap

Forget it. The JTAG/COP is much more complicated than the BDM  inter-
face.  Even  if  you get he information (under NDA), you will spend a
lot of work implementing the stuff, and  getting  things  worling  is
probably anything else but fun.

>  something that will load a real bootloader through the
>  uart.  Is enough information about the BDM available to do
>  this?  I'm not afraid of hacking something together if the
>  information is there.

Even if you calculate just a very low hourly rate you will be  better
off with buying a BDI2000.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
