Date: Tue, 8 Dec 1998 09:49:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Tom Rini <tmrini@ntplx.net>
cc: Martin Costabel <costabel@lie.univ-rennes1.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
In-Reply-To: <Pine.LNX.4.05.9812071636130.1031-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.4.03.9812080947230.15479-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Tom Rini wrote:
> On Mon, 7 Dec 1998, Martin Costabel wrote:
> > The 2 servers from Geert's that I tried didn't want to run on pre-R5. I don't 
> > quite know why, because they dump 2 pages of messages on the screen, only the
> > second of which is visible. This is a help file. I guess the real errors are
> > mentioned on the first, invisible, page. Not very helpful.
> 
> Hmm.  Possibly a problem running it on valkfb?  Geert?

That's quite reasonable. There were some changes in XF68_FBDev that may make it
break on frame buffer devices that aren't 100% compliant. Guess I need to dump
more info with the -verbose flag.

Martin: what about redirecting the X server output to a file, like

    XF68_FBDev >& /tmp/out

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
