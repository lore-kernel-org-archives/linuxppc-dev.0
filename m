Date: Wed, 17 Mar 1999 18:46:56 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Open Source: the drivers
In-Reply-To: <Pine.LNX.3.96L.990317153729.4041A-100000@unix48.andrew.cmu.edu>
Message-ID: <Pine.LNX.3.96.990317183100.27888B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Mar 1999, Hollis R Blanchard wrote:

> And another question: how is it that OS X, based on Mach, is still comparable
> in speed to other non-microkernel operating systems? It was my (uneducated)
> impression that one of the tradeoffs of a microkernel was a performance
> penalty.

There is a performance penalty, but not very much.  This is substantially
reduced when the server is collocated (loaded into kernel space), since
this eliminates the need for message passing.  The reason MkLinux has a
bigger speed tradeoff has less to do with the MK architecture and more to
do with slow legacy drivers. Many of MkLinux's drivers can be traced back
for a number of years (some, like the serial driver, may even date back to
pre-Mac days -- not positive, though).  Since MacOS X and X Server use
different drivers (with different driver frameworks, etc.), they should
perform better because of that alone.  Apple's compiler optimization no
doubt helps, too, though. :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
