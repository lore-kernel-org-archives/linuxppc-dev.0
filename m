Date: Thu, 26 Aug 1999 10:01:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <19990825122335.016707@mail.mipsys.com>
Message-ID: <Pine.LNX.4.10.9908261000210.29782-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Benjamin Herrenschmidt wrote:
> BootX will load the kernel in the first contiguous region in memory it
> can find, but that means that we have to copy the exception vectors to 0,
> adjust them so they call correctly the kernel routines in the real base
> of the kernel (which will not be 0 on some machines), and we'll have
> virt_to_phys and co be non-constant. I read an interesting suggestion
> some time ago of reserving a register during kernel compile with gcc and
> using this register to store the real base of the kernel. Modules will
> not be compatible, but that's not a real issue for now.
> I don't know how the APUS code works, but I heard it is similar.

The latest APUS patches use a fixup section and code to adjust KERNELBASE after
boot up.

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
