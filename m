Message-ID: <3978FB1C.388059D1@denise.shiny.it>
Date: Fri, 21 Jul 2000 21:38:36 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: progress on l2cr
References: <3973882B.1C9A581E@noos.fr> <20000718080355.26687@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> +   p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");


Is there any reason to keep the L2 cache data-only ?


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
