Date: Tue, 5 Dec 2000 11:59:45 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Florin Boariu <florin@bnv-bamberg.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: wrong place?
In-Reply-To: <Pine.LNX.4.21.0012042344440.19403-100000@wolverine>
Message-ID: <Pine.HPX.4.10.10012051158130.3044-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 4 Dec 2000, Florin Boariu wrote:

>
> Hi!
>
> I'm very new to this list (about 30 sec) and before I start and bother
> people, I'd like to ask if I'm in the right place.
>
> I actually do not intend to really develop linux-ppc since I don't think
> I'm good enough. I have some experience in C coding, I even wrote a linux
> device driver once (not necessarily the best one, but anyway... it works)
> and my main reason is that I want my iBook running linux. Of course, if me
> and my limited knowledge can be of any help, we will :)
>
> Am I a user (and off-topic on this list) or am I a developer (and in the
> right place)?
>
> What I want to do is cross-compile linux (kernel aswell as applications)
> from my current (intel) machine to my new shiny iBook. I already built the
> cross-compiling environment, but I'm having troubles compiling the
> 2.4.0test11 kernel.
>
> It's the following:
>
> powerpc-g3-linux-gnu-ld <snip...>
> 	/usr/src/linux-ppc/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> arch/ppc/mm/mm.o: In function `map_page':
> arch/ppc/mm/mm.o(.text+0xe04): undefined reference to `set_pgdir'
> arch/ppc/mm/mm.o(.text+0xe04): relocation truncated to fit: R_PPC_REL24 set_pgdir


Known bug in official 2.4.0-test11, eitehr revert to test10 or use the BK
or rsync tree.

> drivers/input/inputdrv.o: In function `keybdev_event':
> drivers/input/inputdrv.o(.text+0x16ac): undefined reference to `emulate_raw'
> drivers/input/inputdrv.o(.text+0x16ac): relocation truncated to fit: R_PPC_REL24 emulate_raw
> make: *** [vmlinux] Error 1

I did not know that one, but then I have (mostly) headless machines...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
