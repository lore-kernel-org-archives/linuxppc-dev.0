Date: Tue, 11 May 1999 18:47:09 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: David Edelsohn <dje@watson.ibm.com>
cc: Joel Klecker <jk@espy.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: imac of booting 
In-Reply-To: <9905111522.AA48044@marc.watson.ibm.com>
Message-ID: <Pine.LNX.4.10.9905111846430.21901-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 May 1999, David Edelsohn wrote:
> >>>>> Joel Klecker writes:
> Joel> At 19:59 -0400 1999-05-10, Ben Martz wrote:
> >> Stupid question maybe but I can't find a definitive answer. Can I boot
> >> linuxppc from OF on my iMac? Does the elf loader in OF work?
> 
> Joel> The ELF loader in OF does work (part of the Mac OS boot process uses 
> Joel> it in fact), however it does not like Linux kernel ELF images.
> 
> Joel> Until someone figures out the problem and fixes it, the answer is no.
> 
> 	CHRP does not want just an ELF image, but an ELF image with a CHRP
> "note" section.  The note section describes where to load the image,
> whether the image is running real or virtual, and how to instantiate OF.
> NetBSD has more details about this for their macppc port.  Cort may
> already have addressed some of this for the CHRP-based RS/6000 port work.
> 
> 	CHRP looks for a PT_NOTE section in the loader header and then
> specific magic values in the section itself.

What about doing the same as for the CHRP LongTrail (arch/ppc/chrpboot/)?

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
