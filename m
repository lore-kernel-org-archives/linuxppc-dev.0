Date: Thu, 22 Jul 1999 15:11:07 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Naushit Sakarvadia <nsakarvadia@telogy.com>
cc: "'LinuxPPC Developpers'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Newbee
In-Reply-To: <61891BA043DED21180920090273F173829B0C6@argentina.telogy.com>
Message-ID: <Pine.LNX.4.10.9907221510430.18791-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Jul 1999, Naushit Sakarvadia wrote:
> Although I am experienced in x68 Linux but I am very new to PPC stuff.
> First of all I want to cross compile a Kernel for PPC based embedded
> platform.
> 
> For that I downloaded a emmedded kernel port by "Dan Malek" from FTP site.
> 
> When I configure thru "make configure" it doesnt give me processore option
> for PPC...
> 
> How do u inform your build a PPC target?

When crosscompiling, use `make ARCH=ppc other_make_options'

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
