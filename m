Date: Mon, 5 Mar 2001 18:48:29 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Console text selection bug
In-Reply-To: <3AA12536.DAF3B1A7@denise.shiny.it>
Message-ID: <Pine.LNX.4.21L.0103051847240.14824-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Mar 2001, Giuliano Pochini wrote:
>
> When I select text in console it's scrambled. I looked at the
> aty128 sources, but I didn't find anything about it. Where is
> the code that manages selection/cut/paste ?
>
> The selected text is scrambled in this way: every char has
> the bits 1,2,3 swapped with bits 5,6,7 respectively (bits
> numbered left to right). I don't know what can cause this
> strange behaviour... I thought the console screen was a
> simple array of char/colour pairs.
>
> [b/w G3, r128, all kernels]

I don't see this (B&W G3, 2.2.19pre14). I understand this is only a problem if
you enable VGA console (which I don't have enabled).

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
