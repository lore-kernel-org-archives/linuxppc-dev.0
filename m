Date: Fri, 13 Aug 1999 10:43:58 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: drow@false.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908122005.WAA00317@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9908131043270.19651-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Aug 1999, Michel Lanners wrote:
> On   8 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
> > On Sun, Aug 08, 1999 at 09:54:12PM +0200, Michel Lanners wrote:
> >> >> > /dev/hdc:
> >> >> >   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec
> >> ;-)) How about this:
> >> 
> >> /dev/hde:
> >>  Timing buffered disk reads:  64 MB in  6.60 seconds = 9.70 MB/sec
> >> Maxtor 91024D4; 10G 7200 RPM, UDMA-2 ie 33 MB/s.
> > 
> > Eek.  I want that :)
> 
> No, you'd rather want _this_:
> 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in  4.67 seconds =13.70 MB/sec

Stop whining and buy an UW-SCSI disk :-) My Viking II flies at 17 MB/s.

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
