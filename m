Date: Wed, 20 Jan 1999 22:09:42 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Ranjit Deshpande <ranjitd@sco.COM>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI-PCI bridges
In-Reply-To: <Pine.SCO.3.96.990120111039.13973A-100000@mammoth.sco.com>
Message-ID: <Pine.LNX.4.03.9901202208430.28223-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 20 Jan 1999, Ranjit Deshpande wrote:
> 3. Why is the tulip code not reading the EEROM ? I'm using the standard
>    drivers/net/tulip.c. Does it require any PMAC specific changes ?

Does it help if you use the de4x5 driver instead of tulip? On my 21041, tulip
doesn't work, de4x5 does. On Intel both drivers work with the same board.

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
