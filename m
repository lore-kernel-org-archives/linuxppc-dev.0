Date: Tue, 31 Aug 1999 11:11:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: Paul.Mackerras@cs.anu.edu.au, ddkilzer@computer.org,
        schmitz@opal.biophys.uni-duesseldorf.de,
        linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <199908310904.LAA02843@lxp02.cern.ch>
Message-ID: <Pine.LNX.4.10.9908311110520.2087-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 31 Aug 1999, Jes Sorensen wrote:
> Heh, I have been wanting to clean up the driver hierachy for a very long
> time, it is really silly that we keep copying old drivers and change 50
> lines of code to make them run on a new machine. This is the case with
> the 8530 driver, but even worse for the Lance Ethernet one.

Linux' advertisement should become: we have more Lance drivers than supported
architectures.

Last time I counted them, I needed more fingers.

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
