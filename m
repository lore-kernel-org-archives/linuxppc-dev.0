Message-Id: <199912060651.HAA00385@piglet.grunz.lu>
Date: Mon, 6 Dec 1999 07:51:56 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Update:  RE: G4 + Linux + PCI device + x86 driver = 0
To: geert@linux-m68k.org
cc: dwp@bluesteelnet.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.9912052040150.376-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

On   5 Dec, this message from Geert Uytterhoeven echoed through cyberspace:
>> David pointed out le16_to_cpu() et al; personally, I use in_/out_le32
>> et al for access to PCI memory space like this:
>> 
>> out_le32 (&device->register, val);
> 
> Which is wrong! Portable PCI memory space accesses must be done using
> {read,write}[bwl]()!

Ooopppss.... Thanks for letting me know. I guess it doesn't make much
difference, because the code I use it in is purely PowerMac, but
anyway... I'll go read...

> See linux/Documentation/IO-mapping.txt 

....that ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
