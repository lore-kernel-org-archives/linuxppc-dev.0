Date: Fri, 16 Apr 1999 14:19:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: First attempt for LinuxPPC on a MVME2400
In-Reply-To: <37173F25.D38CAD3F@fi.infn.it>
Message-ID: <Pine.LNX.4.10.9904161418590.15413-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 Apr 1999, Simone Piccardi wrote:
> there are some differences, and no presence of the line:
> PCI Bus Bridge Device
> ID/Revision...................=48011057/01                
> that seems replaced by:
> PCI Function 00/00/0 (00000000) ID/Revision.........=48031057/01
                                                       ^^^^^^^^
Is this the Motorola Hawk? It's not yet know by pciutils. Please inform
pci-ids@ucw.cz.

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
