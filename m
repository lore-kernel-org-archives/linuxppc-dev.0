Message-Id: <199908180549.HAA00305@piglet.cpu.lu>
Date: Wed, 18 Aug 1999 07:49:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: gnome-ppp and the mac serial ports
To: Anthony.Lester@lip6.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37B92306.A8377B94@lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  17 Aug, this message from Anthony Lester echoed through cyberspace:
> 
> I've finally got gnome-ppp working after commenting out a section of the source code which
> checks the DCD (Data Carrier Detect) line of the serial port. The kernel code
> corresponding to this check is in the file "macserial.c" and sets various bits of a status
> byte according to the value of a register in the zilog uart which handles the standard mac
> serial ports.
> 
> However the standard RS422 mac ports only have handsake-in and handshake-out lines
> (corresponding to RTS and DTR for the RS232 I think) so there is no line corresponding to
> DCD. So how would it get DCD?

IIRC, DCD is wired to the GPi pin (is that the right name?). That's
some kind of multipurpose pin, that can be used for various things like
sync clocking, remote power-on, etc.... Have a look at your hardware
with a tool like TattleTech; the section about serial ports should show
if/whether DCD of the SCC is wired to the GPi pin.

You might want to search the TIL (http://www.apple.com/til) about
articles about the subject.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
