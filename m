Message-Id: <199909160722.JAA00359@piglet.cpu.lu>
Date: Thu, 16 Sep 1999 09:22:41 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: stty < /dev/modem blocks???
To: rrschulz@cris.com
cc: ldl@chpc.utah.edu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04210100b40584bafd82@[206.173.234.246]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Sep, this message from Randall R Schulz echoed through cyberspace:
> As you know, the less-than (<) operator in all Unix shells opens the 
> file name given as an argument before it executes the command. In 
> order for an open() call on a TTY device to complete, the RS232 
> hardware signals that indicate the presence of an active device 
> connected to the port. In practice, this means that the DTR (data 
> terminal ready) signal must be asserted before the open call will 
> return.

OK, this sounds right, but how do you explain that I can get at the tty
settings with

stty -a < /dev/ttySx

for both of my serial ports, with absolutely nothing connected to them?

;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
