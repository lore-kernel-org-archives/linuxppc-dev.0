Date: Tue, 14 Sep 1999 16:02:12 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Timothy Wall <twall@tiac.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing space on ext2fs scsi drive
In-Reply-To: <37DE4485.8208318@tiac.net>
Message-ID: <Pine.LNX.3.96L.990914155416.2958E-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Sep 1999, Timothy Wall wrote:
> 
> Hollis R Blanchard wrote:
> 
> > On Mon, 13 Sep 1999, Timothy Wall wrote:
> > >
> > > I've run into an odd problem that I'm not quite sure how to diagnose.
> > >
> > > My root partition  (a 2Gb partition on an 8Gb drive) shows (with "df")
> > > around 55% usage (2203440 1k-blocks, a little over half used) and yet
> > > fails complaining that the disk is full.   I don't recall exactly how I
> > > partitioned the disk (probably pdisk).
> > >
> > > Is my ext2fs accounting screwed?  Why does the FS think there is no
> > > space when writing, but show space with "df" ?
> >
> > Run 'df -i'. This shows you your inode usage. Full, isn't it? Time to
> > backup, reformat (with mke2fs), and reinstall.
> 
> Yup, that's the problem.  It seems the installer short-inoded me.

Yeah. The problem (I hear) is that just running mke2fs on a large hard drive
from the installer will lock up machines will less than very large amounts of
RAM. Although now that I think about it, if you're able to run mke2fs by hand
and it works fine, maybe there really isn't a problem. What are your system
specs, and can you run mke2fs sans arguments without problem?

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
