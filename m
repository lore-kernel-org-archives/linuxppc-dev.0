Date: Thu, 29 Apr 1999 17:25:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Bill Whitehead <parman@bwhitehead.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: help with bootup code
In-Reply-To: <3727E20F.BC03ADD2@bwhitehead.com>
Message-ID: <Pine.LNX.4.10.9904291724570.22158-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Apr 1999, Bill Whitehead wrote:
> I am just learning Linux and hope to port it to a custom platform using
> older I/O chipsets(W83c553 and 87307). Basically the system consists of
> a 603/MPC106 with 64M sdram, PCI to ISA and IDE interface(W83c553), and
> I/O controller(87307). I believe the basic system is already supportted
> by Linux but support for I/O chipsets must be added. I am using LinuxPPC
> 4.1 while waiting for release 5.

> I have been monitoring this list for a few weeks and have not seen these
> chips mentioned except once when someone, from Korea(?), indicated they
> were interested in porting Linux to a Motorola YellowKnife system which
> uses them. (if your that person let me know how its going!)

MPC106, W83c553 and NS87307 are all supported in one or more systems. Hence the
basic code is there.

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
