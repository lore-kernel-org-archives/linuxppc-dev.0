Message-Id: <200001261704.JAA16701@mr-ed.jpl.nasa.gov>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compiling standard utilities for 860
Date: Wed, 26 Jan 2000 09:04:36 -0800
From: Matthew R Wette <mwette@grover.jpl.nasa.gov>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk writes ...
>
> In message <388F1A55.D62E35B4@netx4.com> Dan Malek wrote:
> >
> > You have to be careful here.  If you choose to use the in-line
> > floating point software, you must use it for all applications
> > because the libraries are built to do this as well.  You can't
> > mix programs that use the kernel FPU emulation and also in-line
> > software floating-point.  The kernel works out of the floating
> > point register area in the TSS, while the software float assigns
> > real processor registers (and other memory locations) to contain
> > the floating-point values.
>
> I am aware that  I  cannot  mix  this  WITHIN  ONE  application,  for
> instance  compiling  the  app  with  soft-float and linking against a
> library that uses the kernel FPU emulation.
>
> Are there really problems when running soft-float only  and  FPU  emu
> only applications on the same machine? I did not expect any...

I think this may be a problem if the compiler uses registers to pass
arguments to and/or return values from functions.  I'd guess if you
can fix that issue then you might be OK.

Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
