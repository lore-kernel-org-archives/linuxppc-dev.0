Date: Fri, 19 Nov 1999 19:45:57 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Eric Dorland <dorland@lords.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
In-Reply-To: <Pine.LNX.3.96L.991119222014.8832A-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.LNX.3.96.991119194104.4127B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Nov 1999, Hollis R Blanchard wrote:

> On Fri, 19 Nov 1999, Eric Dorland wrote:
> > 
> > There seems to be a problem with the SWIM3 controller on my PowerMac G3.
> > Whenever I try to do any floppy realted operation (mount, dd, whatever) it
> > gives me this error:
> > 
> > end_request: I/O error, dev 02:00 (floppy), sector 36
> > 
> > does anyone know what this means or has had similar problems?
> > 
> > I'm running R5 on a a kernel I compiled myself, but not with anything
> > outrageous, just a few patches. I've got a G3/266, and I'm running linux off
> > a internal scsi drive.
> 
> Are you *positive* your floppy's good? Have you tried others?

Does sound like a bad block, yeah.  If it happens for several disks that
way, and if your drive works right in MacOS, you might see if MkLinux can
read it.  If MkLinux's floppy code reads it and LinuxPPC's doesn't, it's a
bug in the driver.  If, on the other hand, MkLinux's floppy driver fails
as well, you'll probably get more debugging messages than you could ever
possibly want....


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
