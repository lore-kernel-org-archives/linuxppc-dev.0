Message-Id: <200011090650.HAA00645@piglet.grunz.lu>
Date: Thu, 9 Nov 2000 07:50:00 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb and X
To: bob@kunk.jriver.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001106032750.5523.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   5 Nov, this message from Robert E Brose II echoed through cyberspace:
> With 2.4.0-test10 (which includes dma and parameter line changes in
> controlfb) forcing the video ram to 4 megs works fine for console
> modes (for example vmode 17 32) HOWEVER when the XF86_FBdev server
> is run it locks up the machine with a black screen of death. (not
> pingable, keyboard is dead, etc).
> Also, building my own Xfree 4.01 server results in the same black
> screen of death.
> OTOH Xpmac rev 10 works fine (but doesn't support serial mice AFAIK).

I'm now having the same problem with benh's dev tree. The really ugly
part is that there is no information on what happened nowehere: nothing
in X's log files, no oops in the syslog, no kernel panic on the serial
console... the kernel just seems to stop hard.

I've diffed benh's tree against Paul's latest copy I have (which doesn't
lockup with X), but without any clue so far. controlfb is identical
between the two....

I'll keep on investigating.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
