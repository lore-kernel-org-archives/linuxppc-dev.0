Message-Id: <200001261650.RAA01770@denx.local.net>
To: Dan Malek <dan@netx4.com>
cc: Wolfgang Denk <wd@denx.de>, brian.neidig@ni.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compiling standard utilities for 860
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Jan 2000 11:01:25 EST."
             <388F1A55.D62E35B4@netx4.com>
Date: Wed, 26 Jan 2000 17:50:51 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <388F1A55.D62E35B4@netx4.com> Dan Malek wrote:
>
> You have to be careful here.  If you choose to use the in-line
> floating point software, you must use it for all applications
> because the libraries are built to do this as well.  You can't
> mix programs that use the kernel FPU emulation and also in-line
> software floating-point.  The kernel works out of the floating
> point register area in the TSS, while the software float assigns
> real processor registers (and other memory locations) to contain
> the floating-point values.

I am aware that  I  cannot  mix  this  WITHIN  ONE  application,  for
instance  compiling  the  app  with  soft-float and linking against a
library that uses the kernel FPU emulation.

Are there really problems when running soft-float only  and  FPU  emu
only applications on the same machine? I did not expect any...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anyone who isn't confused here doesn't really know what's going on.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
