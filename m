Date: Sat, 12 Dec 1998 15:55:44 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Sean Harding <sharding@oregon.uoregon.edu>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New XF68_FBDev
In-Reply-To: <Pine.SGI.4.02.9812111909270.10099-100000@gutenberg.uoregon.edu>
Message-ID: <Pine.LNX.4.02.9812121554560.585-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 11 Dec 1998, Sean Harding wrote:
> On Thu, 10 Dec 1998, Geert Uytterhoeven wrote:
> 
> >     http://www.cs.kuleuven.ac.be/~geert/bin/XF68_FBDev-accel-ppc-19981210.gz
> 
> So, does this file work for everyone, or should only those with
> accellerated video be using this?

On hardware for which no hardware acceleration is available yet, it will work
unaccelerated.

Furthermore you can disable acceleration by adding

    option "no_accel"

to the Device section of your /etc/XF86Config.

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
