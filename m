Date: Tue, 10 Aug 1999 17:24:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Adrian Cox <apc@agelectronics.co.uk>
cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: More CVS troubles
In-Reply-To: <37B04032.A3E13031@agelectronics.co.uk>
Message-ID: <Pine.LNX.4.10.9908101718540.3140-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Aug 1999, Adrian Cox wrote:
> I'm trying to merge the latest updates from openprojects.net into my
> local tree with cvs update, but every time I get a conflict I get the
> following messages, and cvs exits. Where does /home/jtg come from, and
> what does this all mean?
> 
> RCS file: /cvs/linux/linux/drivers/char/serial.c,v
> retrieving revision 1.51
> retrieving revision 1.51.2.1
> Merging differences between 1.51 and 1.51.2.1 into serial.c
> M drivers/char/serial.c
> cvs [server aborted]: can't chdir(/home/jtg): No such file or
> directory   
> 
> The merge happens fine, and when I restart the update it continues to
> the next merge. But restarting the update is making the process very
> slow, and I would like to find out if 2.2.11 is really a disaster.

I saw the same: update works fine, until after the first merge.

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
