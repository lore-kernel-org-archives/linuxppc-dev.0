Date: Mon, 25 Jan 1999 22:27:43 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: David Edelsohn <dje@watson.ibm.com>
cc: "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Help from Kernel Gurus needed!!! 
In-Reply-To: <9901251746.AA47496@marc.watson.ibm.com>
Message-ID: <Pine.LNX.4.03.9901252224310.29711-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Jan 1999, David Edelsohn wrote:
> 	If you are just trying to copy r1 into r0, why not use move
> regsiter instead of add immediate as the following:
> 
> 	__asm__ ("mr %0,1" : "=r" (p) : );

Hehe, the clue is that IBM/Motorola didn't implement instructions that perform
operations that can be done in a different manner, too.

`mr' is just an alias for add with zero.

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
