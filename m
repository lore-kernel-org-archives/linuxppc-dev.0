Date: Thu, 11 Mar 1999 09:26:30 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: David Edelsohn <dje@watson.ibm.com>
cc: Nathan Hurst <njh@drongo.anu.edu.au>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: What a day for linuxppc! 
In-Reply-To: <9903110506.AA41760@marc.watson.ibm.com>
Message-ID: <Pine.LNX.4.03.9903110924370.5994-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Mar 1999, David Edelsohn wrote:
> >>>>> Nathan Hurst writes:
> 
> Nathan> On Wed, 10 Mar 1999, Martin Costabel wrote:
> 
> >> 1) The 2.2.3 kernel from Linus. Unfortunately it doesn't compile on PPC,
> >> because Paul's semaphore patches didn't make it. The semaphore patches
> >> for Alpha are there, though, and they are not older, so why is this so?
> 
> Nathan> because linus isn't interested in ppc(read, he doesn't have one).
> Nathan> %sigh%  Someone should donate a good machine to him(listening IBM?).
> 
> 	Why doesn't someone find out why the patches are not being
> accepted instead of guessing.  I do not believe that Linus and the core
> team operate this way.

The main problem consists of two parts:

  - Linus get tons of mails and tend to miss some patches (he's human)
  - there's no way to find out whether he accepted your patch or not, until the
    next (pre)release. If we would always get acks (I got an ack for my last
    bunch of video patches, though), life would be much easier.

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
