Date: Sun, 17 Dec 2000 05:21:55 +0900
Subject: Re: problem compiling test12
From: Takashi Oe <toe@unlserve.unl.edu>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B661FD7C.362B%toe@unlserve.unl.edu>
In-Reply-To: <3A3C0420.ADEF0E3C@denise.shiny.it>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 12/17/00 9:09 AM, Giuliano Pochini wrote:

>
> I can't compile 2.4.0-test12:
>
> arch/ppc/mm/mm.o: In function `map_page':
> arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'
>
> Patch ?

Just remove two lines in arch/ppc/mm/init.c::map_page() that look something
like:

    if (....)
        set_pgdir(....);


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
