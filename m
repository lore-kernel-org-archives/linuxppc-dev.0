From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem compiling test12
Date: Sat, 16 Dec 2000 23:11:46 +0100
Message-Id: <19341110154330.5294@192.168.1.10>
In-Reply-To: <3A3C0420.ADEF0E3C@denise.shiny.it>
References: <3A3C0420.ADEF0E3C@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I can't compile 2.4.0-test12:
>
>arch/ppc/mm/mm.o: In function `map_page':
>arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'

Are you using the bk source trees ? The main linus tree is far outdated
on PPC specific parts, unfortunately, Linus has ignored almost all PPC
patches sent for the patch few monthes (despite sending them the way he
wants, in small parts, etc...)

I remember Linus once saying he didn't care about PPC...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
