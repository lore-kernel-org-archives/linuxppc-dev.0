Message-Id: <200005311833.UAA00704@piglet.grunz.lu>
Date: Wed, 31 May 2000 20:33:33 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Lite-On ethernet controller
To: jgarzik@mandrakesoft.com
cc: huberj@wpi.edu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3935145C.DE1F478D@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  31 May, this message from Jeff Garzik echoed through cyberspace:
>> Device information:
>> tulip driver output:
>> eth1: Lite-On PNIC-II rev 37 at 0x1c00, 00:00:94:C5:EF:FF, IRQ 30.
>
> IRQ 30?  Is that ok for PPC?

Yes, actually there are systems that are not limited to 8 IRQs cascaded
into another 8 IRQs ;-))

Seriously, IIRC, desktop PPC systems have at least one interrupt
controller with 32 IRQs. Some even have more... or more controllers.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
