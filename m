Mime-Version: 1.0
Message-Id: <v04210101b406ff058298@[206.173.234.138]>
In-Reply-To: <199909160722.JAA00359@piglet.cpu.lu>
References: <199909160722.JAA00359@piglet.cpu.lu>
Date: Thu, 16 Sep 1999 13:14:08 -0700
To: mlan@cpu.lu
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: stty < /dev/modem blocks???
Cc: ldl@chpc.utah.edu, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel,

It depends on the serial hardware and possibly on the defaults for 
the driver associated with those ports. Not all serial hardware 
behaves identically. I may be wrong about this, but it might be 
possible that a floating input (one connected neither to ground or 
+12) might get interpreted differently on different serial controller 
chips.

Without poring over the pertinent kernel driver code and knowing the 
details of the serial hardware and it's incorporation into your 
computer, I cannot give a more definitive answer.

Randy Schulz
Mountain View, CA USA


At 09:22 +0200 9/16/99, Michel Lanners wrote:
>On  15 Sep, this message from Randall R Schulz echoed through cyberspace:
> > As you know, the less-than (<) operator in all Unix shells opens the
> > file name given as an argument before it executes the command. In
> > order for an open() call on a TTY device to complete, the RS232
> > hardware signals must indicate the presence of an active device
> > connected to the port. In practice, this means that the DTR (data
> > terminal ready) signal must be asserted before the open call will
> > return.
>
>OK, this sounds right, but how do you explain that I can get at the tty
>settings with
>
>stty -a < /dev/ttySx
>
>for both of my serial ports, with absolutely nothing connected to them?
>
>;-)
>
>Michel
>
>-------------------------------------------------------------------------
>Michel Lanners                 |  " Read Philosophy.  Study Art.
>23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
>L-1710 Luxembourg              |
>email   mlan@cpu.lu            |
>http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
