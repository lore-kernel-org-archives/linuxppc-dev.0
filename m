Date: Thu, 4 Feb 1999 21:33:11 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I/O port access ???
In-Reply-To: <Pine.LNX.4.04.9902042015190.4066-100000@goldbach.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.03.9902042132120.17258-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Feb 1999, Gerd Knorr wrote:
> Is there some way to access the I/O ports, for example the VGA registers
> of some graphics board (assuming the I/O ports are enabled in the PCI
> config space) on ppc boxes?  How can I do that with Linux?  From kernel
> space?  From user space?

You have to mmap() /dev/mem. Which address depends on the type of PPC box.
You can find the correct addres in <asm/io.h> (*_ISA_IO_BASE).

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
