Date: Thu, 26 Aug 1999 10:39:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: David Riley <happyoscar42@usa.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <Pine.A41.3.96LJ1.1b7.990825194557.72736C-100000@unlserve.unl.edu>
Message-ID: <Pine.LNX.4.10.9908261010520.29782-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Takashi Oe wrote:
> On Tue, 24 Aug 1999, David Riley wrote:
> > Some of the drivers don't do video=xxxx.  I know controlfb doesn't.  Is there
> > a _good_ reason for this, or does controlfb just not like me?
> 
> It's probably a simple oversight.  Last I checked,
> controlfb does have the necessary code for "video=...", while
> drivers/video/fbmem.c lacks an entry for controlfb to actually activate
> the code.

Fixed this in vger, and sent a patch to Linus.

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
