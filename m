From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@shiny.it>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lots of problems
Date: Fri, 3 Nov 2000 16:44:02 +0100
Message-Id: <19340928091546.1693@192.168.1.2>
In-Reply-To: <XFMail.001103153639.pochini@shiny.it>
References: <XFMail.001103153639.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>> Look at www.penguinppc.org for more infos about those trees.
>
>Are the trees at rsync://vger.samba.org/vger-2.X up to date ?

I don't know for those. The infos are not on penguinppc.org, sorry, but
you can find everything on:

    http://fsmlabs.com/linuxppcbk.html

>The stealth port on my G3 works fine. I thought that card is only an
interface
>and the real serial chip is on the motherboard... G4 is different ?

There is a different wiring of flow control AFAIK. Maybe we miss
something else too. I know some new machines also have an I2C node for
the modem (in addition to the serial port), so it may be necessary to
tweak the modem via I2C before using it. I don't know the details and
AFAIK, Darwin has no code for it yet neither.

>Another little thing: I just upgraded to MacOS904. Booting with BootX linux
>freezes as soon as it accesses the mixer. If I boot without extensions, linux
>doens't crash but I have no sound. No problems with yaboot. (known
prob., uh?)

You should avoid BootX on new machines, it's really not reliable. Some
devices will do bus mastering in MacOS during the boot-process,
potentially damaging the kernel and other bits of memory.

OF booting (yaboot) is the only supported way to boot a newworld machine
now. You may want to look at ybin package from Ethan Benson (there's a
link on my page) that comes with a nice OF multiboot script.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
