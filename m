Date: Mon, 15 Mar 1999 18:09:24 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org, paulus@cs.anu.edu.au
Subject: Re: Blue G3 and machine check
In-Reply-To: <19990316014237Y.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.03.9903151807240.20990-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Mar 1999, Ryuichi Oikawa wrote:
> > While reading of macbsd mailing list, I've seen that the Blue G3 causes a
> > machine check exception while probing a non-existing PCI slot. I don't
> > have time to look into this and I don't have one of those machines, but
> > if anyone want to give a try at fixing this...
> > 
> > (With luck, the second PCI bridge will have been properly setup by OF or
> > BootX and this fix could be enough to get the machine to boot further
> > that It's doing now).
>  As far as I tested(kernel source 2.2.1 from samba and BootX 1.0.2b),
> the kernel freezes within head.S before jumping to start_kernel. It seems
> to completely freeze after the following instructions:

    [...]

Hmm, very similar to the place I suspect to crash my CHRP box. The change was
made somewhere in january, but I still haven't found time to track it down :-(

Greetings,

				Geert (ashamed he's still running 2.2.0)

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
