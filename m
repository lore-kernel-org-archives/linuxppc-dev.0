Date: Thu, 6 Jan 2000 10:50:05 -0700
From: Matt Porter <mmporter@home.com>
To: Eric Valette <valette@crf.canon.fr>
Cc: mporter@mcg.mot.com, Cort Dougan <cort@fsmlabs.com>,
        Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
Message-ID: <20000106105005.C27148@cx258813-a.chnd1.az.home.com>
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com> <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr> <20000106101041.A27148@cx258813-a.chnd1.az.home.com> <3874CE29.C4E19A44@crf.canon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3874CE29.C4E19A44@crf.canon.fr>; from valette@crf.canon.fr on Thu, Jan 06, 2000 at 06:17:29PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 06, 2000 at 06:17:29PM +0100, Eric Valette wrote:
> 
> Matt Porter wrote:
> 
> > > Just to tell you that :
> > >
> > >         1) I applied the 2.2.14pre4 prepide-patch on a clean
> > >         linux 2.2.14 tree. Effectively the ppc part is in and
> > >         not the ide-pci.c, ide-probe.c, and sl82c105.c
> > >         2) BUT : after applying the missing part of the patches
> > >         the behavior is absolutely identical!!!
> > >
> > > hdc : lost interrupt...
> > >
> > > any other hints?
> > 
> > Since you have the old defective MCP750, you can either return it or apply
> > the 99% workaround of reprogramming the level/edge triggering on the VIA as
> > you've done before.  The patch does work on all MCG IDE capable hardware
> > except the revs of the MCP750 that should no longer be used by customers.
> 
> No. That is not so simple : I have also a REV D board that behaves
> exactly
> the same way. If you want I can send you my .config file and the binary.
> Also remember that I managed to have the same linux 2.2.10 image 
> to run on both platforms...

Please send both and cc: mporter@mcg.mot.com

The test platform was a Rev. D MCP750 with multiple IDE drives on hdc/hdd
and a SanDisk in the onboard CF socket (hda).

I'll set this up again on a Rev. D to see if I can recreate it here. I can
only suspect a .config file at this point.  Especially since this patch
is already in the Debian/PPC disty and I've installed whole systems to
IDE drives with no problems. :-/
 
--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
