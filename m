Date: Thu, 4 Feb 1999 22:49:42 +0100 (CET)
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I/O port access ???
In-Reply-To: <Pine.LNX.4.03.9902042132120.17258-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.05.9902042243220.1124-100000@macintoy.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Feb 1999, Geert Uytterhoeven wrote:

> On Thu, 4 Feb 1999, Gerd Knorr wrote:
> > Is there some way to access the I/O ports, for example the VGA registers
> > of some graphics board (assuming the I/O ports are enabled in the PCI
> > config space) on ppc boxes?  How can I do that with Linux?  From kernel
> > space?  From user space?
> 
> You have to mmap() /dev/mem. Which address depends on the type of PPC box.
> You can find the correct addres in <asm/io.h> (*_ISA_IO_BASE).

Can I easily figure out the machine type (at runtime) somehow?  Parse 
/proc/cpuinfo?

   Gerd



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
