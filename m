Message-ID: <39861753.8DB68BB6@denise.shiny.it>
Date: Mon, 31 Jul 2000 20:18:27 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: progress on l2cr
References: <3978FB1C.388059D1@denise.shiny.it> <20000722201320.21455@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Is there any reason to keep the L2 cache data-only ?
>
> There are some rare cases where it can be useful, yes. Like when flushing
> it, to avoid the flush code to pollute it.

A few bytes inside a 1MB cache are't a problem IMHO. Anyway I enabled it and
performance compiling programs is 15% lower.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
