From: Benjamin Herrenschmidt <bh40@calva.net>
To: Alain RICHARD <alain.richard@equation.fr>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iBook and Kernel 2.2.17pre7
Date: Mon, 26 Jun 2000 14:46:13 +0200
Message-Id: <20000626124613.7321@mailhost.mipsys.com>
In-Reply-To: <p04320403b57cee530fee@[192.168.240.10]>
References: <p04320403b57cee530fee@[192.168.240.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 26, 2000, Alain RICHARD <alain.richard@equation.fr> wrote:

>I have just made some tests to the kernel 2.2.17pre7 stable from
>linuxcare on my iBook :
>
>- The atyfb driver now recognize my iBook ATI Mobility 3D Rage L
>chipset. The only problem I have with it is that the initialisation
>mode detection is bad and you have to issue a "vmode 10" to get it
>working properly.

Glad to know it works. I'll look into this init problem. Note that you
may want to try increasing slightly the mclk value. It defaults to 50,
but some users got it working well at 55. for some reason, the speed
difference can be important.

>- The gmac ethernet driver now is able to do promiscuous mode
>(tcpdump) and Appletalk.

Tell me if you have lots of transmitter timeout. If you don't have them
at all, tell me too. Also, I'm interested in some ifconfig stats after
several hours of use.

>I hope to be able to run XFree 4.0 or 4.0.1 at least with the fb
>driver (it seems that the ati driver in XFree do not recognize the
>ATI Mobility 3D Rage L chipset).

Ani Joshi has written some mach64 fbdev. accel support for XF4. It should
be available when someone (Howarth) package 4.0.1 for ppc.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
