Date: Mon, 14 Dec 1998 11:43:53 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
In-Reply-To: <19981214105418.022383@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9812141143100.17418-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Dec 1998, Benjamin Herrenschmidt wrote:
> Another thing that Paul and I are trying to define and implement: A way
> to completely boot from a disk image on the HFS volume (and eventually
> use this image as the read/write root volume). This would allow
> installations of Linux on top of macos without reformatting &
> repartitioning the hard disk.

Thus a generalization of umsdosfs, the UNIX-like fs on top os msdosfs? I think
something like that already exists, read about it on linux-kernel some time
ago.

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
