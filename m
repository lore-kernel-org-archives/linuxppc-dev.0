Date: Mon, 13 Mar 2000 14:10:34 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work
 onppcwithr128
In-Reply-To: <Pine.LNX.4.10.10003131026030.29249-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0003131341340.748-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Mar 2000, Michael Schmitz wrote:

.....
> I found some mention of this in messages from this list, but not a
> complete patch. I changed ppc_icache_flush to only flush one cache line
> (removed the add 32 to r3; repeat flush stuff) and applied the patch to
> the loader I found on the list. That results in no more sig4 or sig11
> during module loads but I still get the Lombard to lock up during real
> server startup. The screen base and size used to map the video memory is
> OK (i.e. taken from the kernel atyfb driver, right aperture and all) but
> it hangs after that. I'll keep digging.
.....
> > Try the fbdev driver with the BusID. (Mach is only minimally accelerated ATM
> > anyway)
>
> Adding the BusID results in the PCI warnings, no change otherwise. The
> server never uses fb_open_pci anyways.
>

  Without the BusID line the XServer will disable the pci memory/io
for the card, it doesn't matter if fbdev_open_pci is used or not.
What probably happens is that even with the BusID defined the xserver
still disables your card.
The PCI warnings that you get most likely will tell us where the problem
is, can you send the logfile over ?

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
