Date: Thu, 6 May 1999 16:43:26 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
cc: John L Grantham <jgrantha@hannover.sgh-net.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Partitions > 2GB?
In-Reply-To: <3731824C.3600@post.uni-bielefeld.de>
Message-ID: <Pine.LNX.4.10.9905061642580.3082-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 May 1999, Jens Ch. Restemeier wrote:
> > It at least _used_ to be so that the various PPC Linuxen couldn't handle
> > partitions larger than 2 GB. Is that still the case as of LinuxPPC R4 and
> > newer?
> 
> I don't know where rumors like that come from... I'm running LinuxPPC on
> a 5 GB partition of a 10 GB IBM harddisk...

Once upon a time, there was a bug in fdisk preventing it to work with disks
larger than 2 GiB on PPC.

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
