From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Control fb problem on 8500
Date: Sat, 19 Aug 2000 13:59:29 +0200
Message-Id: <20000819115929.17289@192.168.1.10>
In-Reply-To: <200008190718.JAA00823@piglet.grunz.lu>
References: <200008190718.JAA00823@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>My XFree 4.0 goes into an infinite loop eating CPU time when I boot a
>2.4.0 kernel. Xpmac does work, but with the artifact described in my
>previous mail.
>
>Anyway, going the way of supporting the hardware cursor is good, but
>we're not there yet ;-)

I have this exact same problem with XF4 on my Pismo (r128) with any 2.4.
The X server dies in this infinite loop and a black screen. Theo only way
I found to get the screen back is to telnet into the box, kill -9 the X
server, and launch Xpmac. This seems to restore the console system into a
working state.

I don't know what's up yet.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
