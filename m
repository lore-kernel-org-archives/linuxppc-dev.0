Date: Sat, 2 Jan 1999 21:55:36 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __init, __openfirmware, etc...
In-Reply-To: <19990102162451.002014@mail.mipsys.com>
Message-ID: <Pine.LNX.4.02.9901022154330.2266-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2 Jan 1999, Benjamin Herrenschmidt wrote:
> Could someone explain me how those directive (__init, __openfirmware,
> __pmac, ...) works in the kernel ? I guess those are directive for the
> linker, and I also guess that __init marked sections will be removed from
> memory after kernel initialisation, but what are the other ones ? 

__init sections are indeed removed after kernel initialisation. The other ones
are removed depending on the dynamic run type of the machine, e.g. __pmac
sections are removed on PReP, and so on. Saves quite some valuable unswappable
kernel memory.

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
