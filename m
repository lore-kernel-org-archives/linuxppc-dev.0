Message-ID: <XFMail.001218151729.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19341110154330.5294@192.168.1.10>
Date: Mon, 18 Dec 2000 15:17:29 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: problem compiling test12
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I can't compile 2.4.0-test12:
>>
>>arch/ppc/mm/mm.o: In function `map_page':
>>arch/ppc/mm/mm.o(.text+0xd90): undefined reference to `set_pgdir'
>
> Are you using the bk source trees ?

No.

> The main linus tree is far outdated on PPC specific parts

Yes, I know it, but I have to test a patch against t12p7 :(  Never mind,
I'll try to adapt it to work on the bk tree.


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
