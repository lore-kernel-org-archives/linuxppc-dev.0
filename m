From: Ryan Nielsen <ran@krazynet.com>
Date: Thu, 19 Aug 1999 23:35:30 -0700
To: Michel Lanners <mlan@cpu.lu>
Cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
Subject: Re: Various PMac PCI patches
Message-ID: <19990819233530.A138@gondolin.asf>
References: <19990819204726.A82@gondolin.asf> <199908200558.HAA00345@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908200558.HAA00345@piglet.cpu.lu>; from Michel Lanners on Fri, Aug 20, 1999 at 07:58:48 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
> > isa_io_base is set to the address of bus 0 !
> > so inl() and friends use wrong address for cards on bus 1.
> 
> That's expected (and broken) behaviour right now; I know how to correct
> the problem, but I need to do some hacking to get it coded right.

What are you plannering ?

I got tulip working by #define _IO_BASE DRIVER_IO_BASE (ifdef) in asm/io.h
and define DRIVER_IO_BASE to a value from pci_io_base(bus) in tulip.c

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
