To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: jack.sun@bmrtech.com,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver and gdb cross debug? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "11 Nov 2002 14:12:02 +0100."
             <1037020322.22840.70.camel@spawn>
Date: Mon, 11 Nov 2002 16:33:37 +0100
Message-Id: <20021111153342.AA1BB10162@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1037020322.22840.70.camel@spawn> you wrote:
>
> Has anybody tried the bdi2000 is that also broken now ?

Works fine here. We're using the ELDK, of course :-)

> What version and patches do people use for gdb on 4xx ?

Version 5.1.1 plus a couple of patches. See the ELDK  source  if  you
are interrested.

> /me really should get my toolchain in order but print(f|k) is so much
> easier to use than first fix the debugger :(

Did you try using the ELDK?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ electronica 2002 in Munich, Nov 12-15, Hall A3, Booth A3.325

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
