Date: Thu, 24 Jan 2002 05:42:46 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: RFC: vesafb
To: hollis@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org, sdi@remote.org
In-Reply-To: <20020123192010.GP510@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16Tbiw-00008o-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  23 Jan, this message from hollis@austin.ibm.com echoed through cyberspace:
> The attached patch allows vesafb to work on PPC. vesafb does surprisingly
> little with the BIOS (which I thought was the whole point of VESA). With some
> ifdef's I'm able to use it as sort of a VGA offb -- the firmware initializes
> the card, and the driver just uses it and never mucks with it.

Wouldn't this be a good start to use generic PC-type grafic cards on PPC
machines in general? Or do you lack initialization if nobody (neither
firmware nor OS) can talk to the card 'natively'?

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
