Date: Thu, 26 Aug 1999 10:03:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Hubert Figuiere <hub@point-barre.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <19990825123612.C2225@rhodan.businessobjects.com>
Message-ID: <Pine.LNX.4.10.9908261001270.29782-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Hubert Figuiere wrote:
> According to Benjamin Herrenschmidt <bh40@calva.net>:
> 
> > is this a NuBus class machine or a PCI based one ?
> 
> 5200 is basically, like the 6200, which is a LC 63O with a
> PowerPC... :-) This means that Linux Mac68k may be of great help,
> and this may lead to a mix of PPC and 68k source trees :-)

Originally the idea was to create machine specific directories for machine
stuff that's shared between architectures (m68k and PPC Amigas and Macs, m68k
and SPARC Suns, `PC' for ia32/PPC/MIPS/AXP/SPARC, ...) in 2.3.x, but due to the
feature freeze announce we won't be able to do that in time...

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
