To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BDI2000 Jtag interface questions... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Oct 2003 10:57:00 +0200."
             <200310141057.00186.david.jander@protonic.nl>
Date: Tue, 14 Oct 2003 11:23:24 +0200
Message-Id: <20031014092329.B7951C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <200310141057.00186.david.jander@protonic.nl> you wrote:
>
> I have heared that the BDI2000 is a must-have debugger for Embedded-PPC
> development (we are developing a MPC852T based board).
> Questions:
> What can you do with the BDI2000 as a Jtag interface for the MPC852T?

MPC8xx processors use a BDM interface. The BDI2000 attaches  to  this
BDM port.

> Is it possible (i.e. is there software) to use the BDI2000 as a Jtag interface
> for that processor to also do hardware testing?

This depends on what you mean by "hardware testing".  Of  course  you
can  use  the  BDM interface - for example - to download and run some
test programs to test your hardware. But BDM is all you get.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We are drowning in information but starved for knowledge.
                                         -- John Naisbitt, Megatrends

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
