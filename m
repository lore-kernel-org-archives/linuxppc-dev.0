Date: Sun, 30 Sep 2001 11:52:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PowerStack interrupt?problem
Message-ID: <20010930115206.E776@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.GSO.4.10.10109301319240.29063-100000@rose.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.10109301319240.29063-100000@rose.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Sep 30, 2001 at 01:23:46PM +0200, Geert Uytterhoeven wrote:

> We're having interrupt problems with a Motorola PowerStack running 2.4.9 (from
> MontaVista rsync).

Goody, which? :)  I've got a 604/100 right here.

> Symptoms are:
>   - We receive lots of PS/2 mouse interrupts (irq 12), a few hundreds or
>     thousands for each mouse move
>   - The number of BAD interrupts increases when moving the mouse, a few tens
>     for each mouse move
>   - Sometimes the machine locks up (no ping response) after heavy mouse
>     movement
>   - The PS/2 keyboard is fine

Hmm.  I sort-of wonder if the PS/2 changes a while back goofed something up.
My kbd is fine too, and I'll try and throw a mouse on later this week.
Can you grab the bk version and go back to 2.4.8, .7, et al and see if
it works?  I think some PS/2 stuff was done in maybe .5 or .6..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
