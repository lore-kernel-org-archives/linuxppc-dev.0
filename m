Date: Fri, 26 Jan 2001 12:22:29 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010126122229.B2874@allspice.cs.swarthmore.edu>
References: <20010125165015.B15827@allspice.cs.swarthmore.edu> <19341221043908.3227@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19341221043908.3227@mailhost.mipsys.com>; from benh@kernel.crashing.org on Fri, Jan 26, 2001 at 12:07:24PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on Fri, Jan 26, 2001 at 12:07:24PM +0100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >I have a Powermac 7500 (with a G3 accelerator.)  I have replaced the
> >internal CD-ROM with a Yamaha CD-RW drive.  This sits on the mesh SCSI
> >bus.  I have the mesh driver configured to run at 5 megabytes/second
> >(since I get massive SCSI problems all over the place if I set it to
> >10.)  Under a variety of kernels, from 2.2.15 or so to 2.4.0 from Paul
> >Mackeras's tree, my SCSI setup is generally stable and I can burn CD-R
> >disks just fine in track-at-once mode.  However, if I try to burn a disk
> >in disk-at-once mode, either with cdrdao or cdrecord, the SCSI bus
> >appears to silently lock up hard, bringing down my whole machine.
> >Nothing is logged at all, as far as I can tell.  Has anyone had this
> >problem before?  Does anyone know of a solution?  If not, how would I go
> >about debugging this further?
>
> Do you see any kind of kernel error messages on the console before it
> locks up ?

Nope, nothing at all.  :-(  It just freezes.  Since the SCSI bus is
gone, any attempts to write to logs fail, as do any attempts to read
them, of course.  cdrdao gets to the "calibrating power" stage, the
light on the cd-rw drive blinks for a few seconds, and that's it.   Last
time I tried this experiment, I at least turned swap off first, and the
system survived a bit longer, but I wasn't able to find anything out.
Is there any other way to probe what's going on?  I do have a 2 gigabyte
drive that I could attach to the external SCSI bus and boot from: maybe
then I could get more info, at least, about what is going on.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
