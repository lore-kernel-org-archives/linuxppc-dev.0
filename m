Date: Tue, 20 Apr 1999 16:27:59 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gabriel Paubert <paubert@iram.es>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Tulip (was: Re: mvme kernel patches [LONG])
In-Reply-To: <Pine.HPP.3.96.990420123601.20020A-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.9904201627060.26859-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Gabriel Paubert wrote:
> On Tue, 20 Apr 1999, David De Ridder wrote:
> > I still have some questions :
> > 
> > * Why is the Generic DECchip driver used instead of the DEC2x41x driver ?
> >   Is this because of the problems with the DEC21143 ?
> 
> Arenn't you confused ? I think they are the sme driver under evolving
> names. The source file is de4x5.c, tulip.c has never worked properly on
> big endian machines. There are still problems with my source on 21143, but 
> Matt Porter just posted agin the necessary patches. 

As of v0.91, tulip.c works again (verified by a friend with a LongTrail).

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
