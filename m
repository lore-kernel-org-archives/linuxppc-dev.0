To: "Mark Powell" <medp@primagraphics.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling/debugging 405GP and RISCWatch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Mar 2001 12:59:30 GMT."
             <03ee01c0b206$c4878ea0$3000a8c0@primag>
Date: Wed, 21 Mar 2001 14:24:18 +0100
Message-Id: <20010321132423.B903A28826@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <03ee01c0b206$c4878ea0$3000a8c0@primag> you wrote:
>
> However, for one very deeply embedded part of the hardware I can't use linux
> (not enough RAM and ROM), I just want a bootstrap to run a single program.
> I'm trying to decide on a debugging strategy and I am considering RISCWatch
> with the JTAG adaptor. I have experimented with RISCWatch using a network
> connection to the Walnut ROM Monitor, but have so far been unable to produce
> an executable with the HardHat/GNU tool chain from which RISCWatch can read
> debugging symbols. The RISCWatch manual says it can read ELF/DWARF files,
> and indeed it seems to download my executable, but gives an error
> "DwarfCompilationUnit: invalid FORM = 0"

Another suggestion: replace the Walnut ROM Monitor  by  PPCBoot,  the
Open  Source Firmware project (see ppcboot.sourceforge.net), and load
and run your program under PPCboot. This  is  explicitely  supported;
see the code in the examples directory.

> Is it possible to use RISCWatch with the GNU toolchain?
> Is it possible to use the RISCWatch/JTAG interface as a backend to gdb?
> Any other suggestions for debugging (with no network connection on the
> target)?

Get yourself a BDI2000. It's a great tool and  works  perfectly  with
GDB, even for Linux, where MMU support is essential.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When a program is being  tested,  it  is  too  late  to  make  design
changes.                  -- Geoffrey James, "The Tao of Programming"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
