Date: Wed, 7 Feb 2001 09:49:54 +0100
From: Olaf Hering <olh@suse.de>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH not found with 2.4.1 on 7500
Message-ID: <20010207094954.A10127@suse.de>
References: <20010206173709.A17234@suse.de> <20010206112148.0c9b60d3.toe@unlserve.unl.edu> <20010207075404.G14283@suse.de> <20010207011911.1fa55761.toe@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010207011911.1fa55761.toe@unlserve.unl.edu>; from toe@unlserve.unl.edu on Wed, Feb 07, 2001 at 01:19:11AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 07, Takashi Oe wrote:

> On Wed, 7 Feb 2001 07:54:04 +0100, Olaf Hering <olh@suse.de> wrote:
>
> > On Tue, Feb 06, Takashi Oe wrote:
> > > message output, you should have something like:
> > >
> > > SCSI subsystem driver Revision: 1.00
>
> The SCSI message is missing once again from your dmesg.  If you are
> absolutely sure your kernel is built with SCSI support, do "make
> distclean" and try again.  If the SCSI subsystem message is still missing,
> attach your .config file along with dmesg.  You are working with bk tree,
> right?  In any case, can't you at least find out where the machine check
> is happening?

It happens with CONFIG_RTC, but appearently only on this 7500/100.
Wallstreet, beige G3 (unverified) and every newworld can have this
option enabled.

CONFIG_RTC is currently a bit useless on pmac so its safe to disable it.
CONFIG_PPC_RTC does the job.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
