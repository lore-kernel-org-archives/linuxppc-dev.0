From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: progress on l2cr
Date: Sat, 22 Jul 2000 22:13:20 +0200
Message-Id: <20000722201320.21455@192.168.1.10>
In-Reply-To: <3978FB1C.388059D1@denise.shiny.it>
References: <3978FB1C.388059D1@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Is there any reason to keep the L2 cache data-only ?

There are some rare cases where it can be useful, yes. Like when flushing
it, to avoid the flush code to pollute it.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
