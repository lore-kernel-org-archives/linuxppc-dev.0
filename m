Date: Thu, 26 Aug 1999 10:55:22 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
Subject: Re: vger-2.3.15 on pmac
In-Reply-To: <37C4FD7C.BBEC0F1@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9908261054470.29782-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 26 Aug 1999, Martin Costabel wrote:
> Thanks to the efforts of Paul M. and Cort, the 2.3.15 kernel from
> cvs.on.openprojects is now compiling on a Pmac (first time after 2.3.6,
> 2 months ago).
> 
> I propose 2 patches: The first one is an obvious correction in the
> valkyriefb driver, and the second one allows to configure support for
> Apple partition maps without going to the section of exotic partitions.
> It is obvious, too.

I just checked in the first one (+ a similar fix to chipsfb) at vger, and sent
a patch to Linus.

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
