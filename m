Date: Thu, 7 Jan 1999 18:30:19 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Brad Midgley <brad@pht.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: system.h and "::"
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990107085341.599A-100000@cricket>
Message-ID: <Pine.LNX.4.03.9901071829510.16860-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Jan 1999, Brad Midgley wrote:
> using the latest snapshot of r5 (and its associated libs/compiler), i have
> a problem with asm/system.h that i hope has a simple fix.
> 
> i wrote a c++ program that includes some system header files. it chokes
> when asm/system.h gets included because "::" appears in that file. that
> has special meaning to the c++ compiler. the compile succeeds if it's
> broken up into ": :" but will that cause any problems? does that have the
> same meaning in assembly? the patch ends this message. 

Thanks! I fixed all occurencies in the vger tree.

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
