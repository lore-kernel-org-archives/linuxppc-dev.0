Date: Sun, 11 Jul 1999 13:13:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Eric Dorland <dorland@lords.com>
cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problems with the atyfb driver on Power Mac G3
In-Reply-To: <l03130300b3a81a797836@[209.226.106.193]>
Message-ID: <Pine.LNX.4.10.9907111312360.392-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Jul 1999, Eric Dorland wrote:
> >What about providing a private ioctl to set those threshold values ? With
> >a simple command line tool and eventually a pair of sliders on X, this
> >would allow people to try out and us to collect infos about behaviour of
> >various values on various configurations, and eventually provide more
> >conservative default values, and letting the user eventually increase
> >performances later.
> 
> Would anyone be willing to write such I beast? I would be more than willing
> to lend a hand (having fair C skills), but I know little about kernel
> hacking and even less about fiddling with video drivers, so I don't know
> how much help I'd be :)

It's on my list. Not the GUI thing of course, but just the ioctl() stuff and a
small program to play with it.

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
