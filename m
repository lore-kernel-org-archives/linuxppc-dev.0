Message-Id: <200008151554.RAA01015@piglet.grunz.lu>
Date: Tue, 15 Aug 2000 17:54:47 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4 ... works
To: pochini@denise.shiny.it
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3999AC2A.1057C171@denise.shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Aug, this message from Giuliano Pochini echoed through cyberspace:
> At boot it complains: "PCI device 01:02.0 non available
> because of resource collisions" and again for 01:03.0.
> They are my 2 SCSI controllers... and it doesn't boot.
> I patches pci.c to ignore the error and now it seems to
> work fine, but I don't like that hack.

What SCSI controllers are those? Anyway, to get this resolved in a clean
way, you need the PCI resource allocation patches from Geert or me (but
I don't have updated patrches for 2.4.0-test kernels).

In any case, even with resource conflicts, it should boot fine, albeit
without the SCSI controllers.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
