Date: Mon, 4 Dec 2000 23:55:20 +0100 (CET)
From: Florin Boariu <florin@bnv-bamberg.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: wrong place?
Message-ID: <Pine.LNX.4.21.0012042344440.19403-100000@wolverine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I'm very new to this list (about 30 sec) and before I start and bother
people, I'd like to ask if I'm in the right place.

I actually do not intend to really develop linux-ppc since I don't think
I'm good enough. I have some experience in C coding, I even wrote a linux
device driver once (not necessarily the best one, but anyway... it works)
and my main reason is that I want my iBook running linux. Of course, if me
and my limited knowledge can be of any help, we will :)

Am I a user (and off-topic on this list) or am I a developer (and in the
right place)?

What I want to do is cross-compile linux (kernel aswell as applications)
from my current (intel) machine to my new shiny iBook. I already built the
cross-compiling environment, but I'm having troubles compiling the
2.4.0test11 kernel.

It's the following:

powerpc-g3-linux-gnu-ld <snip...>
	/usr/src/linux-ppc/lib/lib.a \
	--end-group \
	-o vmlinux
arch/ppc/mm/mm.o: In function `map_page':
arch/ppc/mm/mm.o(.text+0xe04): undefined reference to `set_pgdir'
arch/ppc/mm/mm.o(.text+0xe04): relocation truncated to fit: R_PPC_REL24 set_pgdir
drivers/input/inputdrv.o: In function `keybdev_event':
drivers/input/inputdrv.o(.text+0x16ac): undefined reference to `emulate_raw'
drivers/input/inputdrv.o(.text+0x16ac): relocation truncated to fit: R_PPC_REL24 emulate_raw
make: *** [vmlinux] Error 1

I read in your ML archives that the second problem already occured in the
test10 release. I also saw some patches, some did work, others didn't (at
least that's what the archive says). I also read that it was planned to
include those patches in the release. Has this been done (probably
not). What about the first problem (set_pgdir?)

best regards,
florin.
--
[...] try this new version instead, which many people believe to
      be the perfect compromise between new and old bugs. :)

	-- announce of ircII 2.9 "roof"


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
