Message-Id: <200004030925.LAA00262@piglet.grunz.lu>
Date: Mon, 3 Apr 2000 11:25:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: problems with the frame buffer (ATV 64) on a power mac 7220 in
 newer kernels
To: sjh@wibble.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38E6B3F6.67F0D9A0@wibble.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   2 Apr, this message from Steven Hanley echoed through cyberspace:
> on the power mac 7220 the kernel that came with it works happily
> and as soon as bootx loads it we see the text start apearing during boot
> (along witht the little penguin) and with a 2.2.10 compiled kernel I
> grabbed off samba it also works fine.
[snip]
> I tried a kernel command line of video=controlfb:vmode:5
                                         ^^^^^^^^^
I didn't know the 7220 had a control display adapter? Anyway, this
option will do nothing for your ATI display. You need to look at atyfb
for relevant options.

Michel

PS By the way, anybody know whether the option handling in controlfb
made it into the kernel? Options were there, but control_setup() was
never called, IIRC.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
