Message-ID: <3A24C62F.D69C7558@pop.agri.ch>
Date: Wed, 29 Nov 2000 10:02:56 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>,
        LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: usb wheel mouse, XF4.0
References: <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseld
	 orf.de> <p0433010ab649bafec687@[206.6.156.5]> <v04220800b64a66157aaa@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:
>
> At 2:55 PM -0500 11/28/00, Stefan Jeglinski wrote:
>
> >I take it you're saying that PCI USB cards are not being officially
> >supported, but they may work. Otherwise I don't get your comment. The
> >backport into 2.2.18 (which will be defined as stable when it is no
> >longer pre status) seems to include config options for many keyspan
> >devices, among others. Are these not PCI cards? I could clearly be
> >dead wrong here, I'm now surmising.
>
> Keyspan does not make any PCI USB cards.  The only PCI cards they
> make are serial cards.  Their USB stuff is all peripherals (such as
> an IR remote widget, USB to serial adapters, etc.).  The config
> options you're seeing are drivers for their USB peripherals.

Didn't follow the thread, but only a notice:

At least the sell one.....

http://www.keyspan.com/products/usb/card/

And it works on my 7200 out of the box with 2.2.17pre15 and up...

lspci -v:

00:0f.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10)
        Subsystem: Unknown device 1045:c861
        Flags: bus master, medium devsel, latency 32, IRQ 25
        Memory at 80801000 (32-bit, non-prefetchable)


Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
