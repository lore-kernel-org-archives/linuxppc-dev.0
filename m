Message-ID: <37DE4485.8208318@tiac.net>
Date: Tue, 14 Sep 1999 08:50:13 -0400
From: Timothy Wall <twall@tiac.net>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing space on ext2fs scsi drive
References: <Pine.LNX.3.96L.990913223653.9981F-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yup, that's the problem.  It seems the installer short-inoded me.

Hollis R Blanchard wrote:

> On Mon, 13 Sep 1999, Timothy Wall wrote:
> >
> > I've run into an odd problem that I'm not quite sure how to diagnose.
> >
> > My root partition  (a 2Gb partition on an 8Gb drive) shows (with "df")
> > around 55% usage (2203440 1k-blocks, a little over half used) and yet
> > fails complaining that the disk is full.   I don't recall exactly how I
> > partitioned the disk (probably pdisk).
> >
> > Is my ext2fs accounting screwed?  Why does the FS think there is no
> > space when writing, but show space with "df" ?
>
> Run 'df -i'. This shows you your inode usage. Full, isn't it? Time to backup,
> reformat (with mke2fs), and reinstall.
>
> -Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
