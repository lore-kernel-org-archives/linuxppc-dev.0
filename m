Message-ID: <3CBC7F1B.FF597841@xilinx.com>
Date: Tue, 16 Apr 2002 12:44:27 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: James Campbell <jcampbell@omnigon.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Virtex II Pro/405GP
References: <1018722334.3710.3.camel@skoll.omnigon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James,

I do have some experience with this chip :-)

As you said the Virtex-II Pro FPGA from Xilinx is a chip consisting of
programmable logic, embedded PPC405 core(s) and integrated multi-gigabit
transceivers. The smallest chip (2VP2) has zero CPUs and four 3.125 Gbit IOs.
The biggest chip (2VP50) has four CPUs and sixteen 3.125 Gbit IOs. The CPU is a
PPC405 core, it is not a 405GP. The user selects the peripherals he wants to
have and synthesizes them into the FPGA fabric. This results in a very flexible
solution that allows for a wide range of system design.

The developer's kit comes - besides HW IP and HW/SW design examples - with GNU
tools. These are cross-development tools for Windows and Solaris and consist of
GCC, binutils, GDB and newlib (with backend to the Parallel-3/Parallel-4 cable
attached to the BDM port/JTAG port for non-intrusive software debugging). The
kit also has simple device drivers and stand-alone/demo applications. The kit
does currently not have any direct support for any OS.

Internally, we tested the latest Linux development kernel and found that it
works just fine on our FPGA (2VP7FF672, one CPU, eight 3.125 Gbit IOs).

Regards,
- Peter


PS: For more information about the
- Virtex-II Pro FPGA:  http://www.xilinx.com/virtex2pro/
- developer's kit:  http://www.xilinx.com/ise/vii_pro/kit.htm


James Campbell wrote:

> Hello,
>
> Does anyone have any experiance with the new Xilinx Virtex II Pro chip?
> It is a million+ gate FPGA device with embedded 405GP cores on the die.
>
> We've recently consolidated our MPC8260 and Virtex II fpgas into this
> single chip, and I'm curious about getting linux up on it.
>
> I know the dev kit comes with GNU software, but I was just curious if
> anyone had any comments on it (good or otherwise).
>
> Cheers,
>
> James Campbell
>
> --
> James Campbell          -|-   Embedded Systems Engineer
> jcampbell@omnigon.com   -|-     Omnigon International
> pgp:  DA57 E174 4769 1B9D D0DF 73E6 D639 D867 A576 A5AE
> work: +1.760.804.8884 x 332       cell: +1.760.803.8476
> --
> "Computer games don't affect kids; I mean if Pac-Man
> affected us as kids, we'd all be running around darkened
> rooms, munching magic pills and listening to repetitive
> electronic music."
>          -Kristian Wilson, Nintendo, Inc. 1989
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
