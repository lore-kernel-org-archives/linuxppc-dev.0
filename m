Message-ID: <002101c2bf2a$d5569c70$0501a8c0@PEGASUS>
From: "Frank Robbins" <frank.robbins@analogue-micro.com>
To: <laudney@acm.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3E2911AE.4090602@sjtu.edu.cn>
Subject: Re: MCR question
Date: Sat, 18 Jan 2003 19:50:18 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


this runs an address pattern from the UPM table on the address bus.
from the location you set-up the location that terminates in the upm table

You have to write this pattern into the UPM table.

It is normally used to set-up the SDRAM for the 860 as it does not have a
SDRAM controller by default.

So things like the control word for the SDRAM chip have to be written to the
chip via the address bus i.e .. for CAS latency, interleaving etc.

Hope this help

Its really quite clever .. but very confusing

Frank

----- Original Message -----
From: "Laudney Ren" <bren@sjtu.edu.cn>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, January 18, 2003 8:34 AM
Subject: MCR question


>
> Hi, all:
>
>   From MPC860 User Manual, MCR has a field named "OP". when its value is
> 10, the operation is "RUN". The description for "RUN" in the manual is:
>
> "... the AMX bits of the UPM RAM word in this software initiatede
> pattern must all be set to 0b11. Thus, the address for this pattern is
> the value written to MAR. The data bus is not driven."
>
> My question is, what does the "pattern" mean? What's its use? What is
> the "address for the pattern"? Is this address a RAM address and the
> pattern will be read from this location? What is MAR for?
>
> Thanks.
>
> Laudney Ren
>
> --
> An expert is one who knows more and more about less and less
> until he knows absolutely everything about nothing.
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
