Message-Id: <200108220543.HAA00747@piglet.grunz.lu>
Date: Wed, 22 Aug 2001 07:43:55 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Strange OF display while booting
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010819215836.31159@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On  19 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>With recent BenH kernels, the early boot messages (before switching to
>>aty128fb in my case) are messed up. The first few messages start in the
>>middle of the top row, with some white areas to the left of the
>>messages, then at the middle hight of the screen there's a white area
>>spannig all the width, and below that the text messages are aligned
>>correctly again to the left edge of the screen.
>
> That code have been hacked a bit by both paulus and me lately. Can
> you try out my current rsync ?

Fixed, thanks!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
