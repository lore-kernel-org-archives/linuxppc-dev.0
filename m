Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Bob Piatek" <bobtek@fishcamp.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
	"'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: "'LinuxPPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SCCx _and_ external UART on MPC8xx??? 
Date: Wed, 5 Jun 2002 09:29:50 -0700
Message-ID: <000b01c20cae$3d36ce80$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020605161948.5FFB2102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I can send you the SC26x198 Octal UART driver sources if you want.

I too am interested in this.  Can you point me to a link where to get
the sources?

Bob Piatek

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of
Wolfgang Denk
Sent: Wednesday, June 05, 2002 9:20 AM
To: Steven Scholz
Cc: LinuxPPC
Subject: Re: SCCx _and_ external UART on MPC8xx???


Dear Steven,

in message <3CFE2C5C.F66B5810@imc-berlin.de> you wrote:
>
> > Yes, we do. We have one board with 2  x  external  octal  UARTS,
and
> > ethernet on SCC1.
> Would you mind telling me where I can found a sample
configuration/code?

The configuration is the VL100 board, see
http://www.denx.de/embedded-ppc-en.html

It uses 2 Philips SC26x198 Octal UARTs and a slightly modified
stallion multiport serial driver.

I can send you the SC26x198 Octal UART driver sources if you want.

> > What exactly is your problem?
> It seems that that standard linux driver for 16550 UARTs relies very
> much on i86 PC architeture.
> During my first tries I couldn't tell him that my UART is NOT at 0x2f8
> or whatever.
> So that's the problem.

But it's being used on a couple of PowerPC boards, you just  have  to
configure it correctly ;-)

> I just want to enable CONFIG_SERIAL _and_ CONFIG_SMC1_UART and expect
it
> to work... :o)
> Maybe I should have a look at the (just discovered) option
> CONFIG_SERIAL_NONSTANDARD!? What do you think?

Look at existing board configurations. Most use  just  CONFIG_SERIAL,
CONFIG_SERIAL_CONSOLE, CONFIG_SERIAL_EXTENDED, CONFIG_SERIAL_SHARE_IRQ.

In our case there were no conflicts, because  our  SC26X198  _was_  a
non-standard driver.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I used to be indecisive, now I'm not sure.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
