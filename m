Date: Sun, 2 May 1999 14:52:03 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI configuration space access from user apps?
In-Reply-To: <19990501005349A.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.10.9905021451510.773-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 1 May 1999, Ryuichi Oikawa wrote:
> Is there any service available on LinuxPPC that can safely
> access(R/W) PCI configuration space from user applications?

setpci, part of pciutils.

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
