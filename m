Date: Tue, 10 Aug 1999 14:56:12 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: mlan@cpu.lu, drow@false.org, mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908100010.KAA19153@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9908101455510.32043-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Aug 1999, Paul Mackerras wrote:
> Michel Lanners <mlan@cpu.lu> wrote:
> > I'd vote for making I/O ports a memory addresss like any other, and
> > making sure drivers get this address right. See my other post for
> > details..
> 
> The problem is, there are PCI device drivers which assume you can get
> an address in I/O space from a PCI device (either directly from the
> config-space base address registers or from the pci_dev struct) and
> then just do inb and outb on that port address.  That's why inb/outb
> add _IO_BASE to the port number.
> 
> One way might be to adjust the base addresses in all the pci_dev
> structs and then make sure all drivers use the address from the
> pci_dev struct rather than reading config space themselves.

Which will make our /proc/ioports look funny.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
