Date: Thu, 14 Jan 1999 23:35:06 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Paul Mackerras <paulus@cs.anu.edu.au>, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: new irq.c
In-Reply-To: <Pine.LNX.3.96.990114142507.7102A-200000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.03.9901142334560.17386-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Jan 1999, Cort Dougan wrote:
> This is the latest version of the new irq.c
> 
> As it is, chrp needs to be improved a bit (it still uses the old
> irq_to_openpic() style of things) but that's not a problem right now.
> 
> Please try it out, if you have problems let me know.  If things look good
> I'll go ahead and commit it to VGER.

Works fine on my CHRP box.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
