From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Date: Wed, 27 Sep 2000 19:22:30 +0200
Message-Id: <19340822105414.6793@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10009271341020.383-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009271341020.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> One thing: I'd be interested in figuring out what happens if you simply
>> leave this nasty ATI BAR unassigned (write 0xffffffff and then 0 to it).
>> Will the controller fail ?
>
>Well, according to Matt Porter, 0 is a valid address in PCI 2.2. So how
do you
>disable BARs for PCI 2.2-compliant devices?
>
>And I'm afraid what XFree86 4.x will do with BARs set to 0. Probably it will
>try to relocate them. I guess that's how it crashes on my box with an
>unitialized S3...

Well, I may be wrong here, but the cause of our problem (the MMIO BAR
overlapping the framebuffer BAR causing XFree to bark) may also be an
XFree problem. I think we never completely figured out if what MacOS does
to the chip is valid or not (because of priority-decoding).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
