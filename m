Date: Sat, 19 Jun 1999 22:49:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bob Doyle <doyle@primenet.com>
cc: Nye Liu <nyet@nbase.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Motorola MPC8240 Sandpoint embedded linux
In-Reply-To: <376C01F3.666112C3@primenet.com>
Message-ID: <Pine.LNX.4.10.9906192248130.327-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 19 Jun 1999, Bob Doyle wrote:
> > Verify that the current serial drivers work with the Sandpoint's NS
> > PC87308.
> 
> The code in dink has code to initialize the two serial ports.
> 
> If you want to get the floppy, mouse, keyboard, parallel ports, etcs
> going you've got to configure the '87308 for that.  It looks like all
> you have to do is provide the base addresses for the peripherals
> to the '87308.
> 
> I couldn't find docs on National's website for the '87308 but I was
> able to get the floppy going by just reading the dink code.  Anybody
> know where to get docs?

I have the doc in PDF format. Let me know if you want a copy by email. I don't
have the CD with the doc at hand, but I can send it tomorrow.

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
