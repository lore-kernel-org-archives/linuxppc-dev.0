Date: Mon, 5 Jun 2000 12:59:35 -0700
From: Daniel Jacobowitz <drow@false.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI resource assignment
Message-ID: <20000605125935.A21551@quaketop.them.org>
References: <Pine.LNX.4.05.10006050927350.5397-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10006050927350.5397-100000@callisto.of.borg>; from geert@linux-m68k.org on Mon, Jun 05, 2000 at 09:42:02AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 05, 2000 at 09:42:02AM +0200, Geert Uytterhoeven wrote:
>   - I don't know what to do with the code marked with
>
> 	Don't touch IDE controllers and I/O ports of video cards!
>
>     Perhaps we do need to touch IDE controllers on PPC? I don't have IDE
>     devices connected to the IDE interface in my LongTrail, so I don't know.
>     AFAIK the IDE interface does work without fiddling with the PCI resources
>     on other LongTrails, but that could be caused by the different OF in those
>     boxes (that different OF does assign other missing resources, unlike mine).

My experience is that we need to touch IDE cards without Open Firmware
ROM.  I currently have a card that needs this; I have a hideous local
hack in my kernel to enable it.

>

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
