Subject: Re: Radeon problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030719145532.20ff05e3.pochini@shiny.it>
References: <20030719145532.20ff05e3.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1058813681.11026.4.camel@gaston>
Mime-Version: 1.0
Date: 21 Jul 2003 20:54:41 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-07-19 at 16:55, Giuliano Pochini wrote:
> I have a dual G4-mdd with a r9000 and I'm using
> Linux Jay 2.4.22-pre6 #4 SMP sab lug 19 08:29:11 UTC 2003 ppc unknown
>
> Problem #1: Radeonfb sets a video mode that isn't supported by my LCD
> monitor. I have to blindly type "/usr/sbin/fbset -a 1280x1024-60 -depth 16"
> at the root console every time (*if* it boots, because I make the box crash
> quite often :( ). Is there a boot option to set the right video mode ?

Can you send me a dmesg dump (with the wrong video mode) and
a dump of /proc/device-tree/pci@f0000000 ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
