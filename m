To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Oct 2003 16:55:04 BST."
             <DEF39A0710293E489D45B10E06645CBD0243B1E7@dub-msx1.spectelcorp.com>
Date: Thu, 09 Oct 2003 18:18:34 +0200
Message-Id: <20031009161839.6AF46C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD0243B1E7@dub-msx1.spectelcorp.com> you wrote:
>
> I am affraid I am still unable to debug the kernel.

Just to be sure: did you add "-g" to  your  CFLAGS_KERNEL  definition
(in the toplevel Makefile) ?

> I am not unsure if this is relevant but this is the method I am using to
> build the kernel
>
> make TQM8260_config

Don't use TQM8260_config unless you either have a  TQM8260  board  or
you know _exactly_ what you're doing.

> make menuconfig (where I am changing FCC, MDIO and SCC parameters only)

Which means your kernel will  not  work  unless  you  really  have  a
TQM8260 board.

> make oldconfig
> make dep
> make uImage

This looks ok to me.

> VECTOR      CATCH       ;catch unhandled exceptions

Did you try out nocatch as recommended earlier?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I've already got a female to worry about. Her name is the Enterprise.
	-- Kirk, "The Corbomite Maneuver", stardate 1514.0

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
