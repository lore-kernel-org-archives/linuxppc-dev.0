Date: Mon, 7 Dec 1998 14:56:07 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Martin Costabel <costabel@lie.univ-rennes1.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
In-Reply-To: <199812071315.NAA07323@lie.univ-rennes1.fr.maths>
Message-ID: <Pine.LNX.4.03.9812071453440.31794-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Martin Costabel wrote:
> >What about the XF68_FBDev from XFree86 3.3.3?
> 
> I must confess that I am a bit lost among the many different versions of 
> XF68_FBDev. For the one from XFree86 3.3.3, do I have to install all of 
> XFree86 3.3.3, or does it work with XFree86 3.3.2 which is in linuxppc-pre-R5?
> I tried several versions, and both on R4 and on pre-R5, the result was the same.
> Except that some versions did not want to run on pre-R5.

The X server doesn't use any of the X11 shared libs. All it needs is libc and
libm. So if you have to correct glibc, it's supposed to work.

> If XF68_FBDev is going to be the standard for everybody, one should make sure
> that it works on PowerMacs, too.

Sure it has to!

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
