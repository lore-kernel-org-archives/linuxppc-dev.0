Date: Sat, 20 Nov 1999 00:53:42 -0500
From: Eric Dorland <dorland@lords.com>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
Cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
Message-ID: <19991120005342.A515@HSE-MTL-ppp4368.qc.sympatico.ca>
References: <Pine.LNX.3.96L.991119222014.8832A-100000@unix47.andrew.cmu.edu> <Pine.LNX.3.96.991119194104.4127B-100000@deepspace.mklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.991119194104.4127B-100000@deepspace.mklinux.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 19, 1999 at 07:45:57PM -0800, David A. Gatwood wrote:
> On Fri, 19 Nov 1999, Hollis R Blanchard wrote:
> 
> > On Fri, 19 Nov 1999, Eric Dorland wrote:
> > > 
> > > There seems to be a problem with the SWIM3 controller on my PowerMac G3.
> > > Whenever I try to do any floppy realted operation (mount, dd, whatever) it
> > > gives me this error:
> > > 
> > > end_request: I/O error, dev 02:00 (floppy), sector 36
> > > 
> > > does anyone know what this means or has had similar problems?
> > > 
> > > I'm running R5 on a a kernel I compiled myself, but not with anything
> > > outrageous, just a few patches. I've got a G3/266, and I'm running linux off
> > > a internal scsi drive.
> > 
> > Are you *positive* your floppy's good? Have you tried others?
> 
> Does sound like a bad block, yeah.  If it happens for several disks that
> way, and if your drive works right in MacOS, you might see if MkLinux can
> read it.  If MkLinux's floppy code reads it and LinuxPPC's doesn't, it's a
> bug in the driver.  If, on the other hand, MkLinux's floppy driver fails
> as well, you'll probably get more debugging messages than you could ever
> possibly want....

I've tried a bunch of different floppies (at least 5), all give the exactly
same error. The drive works flawlessly in the MacOS. I don't really have
MkLinux installed to test it. Something I forgot to mention. When I try to
to do dd, it gives the error and hangs the terminal. I can switch to another
virt. console, but the dd process refuses to die. Is there something odd
about the G3 floppy drive? Does anyone have this problem?

BTW, is there any utility in the MacOS to write raw disk images? DiskCopy
will mount them, but doesn't seem to want to write them to a floppy. (Its a
Debian i386 bootdisk).

Eric Dorland
dorland@lords.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
