Date: Mon, 13 Sep 1999 22:38:04 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Timothy Wall <twall@tiac.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing space on ext2fs scsi drive
In-Reply-To: <37DDA89E.8B35952D@tiac.net>
Message-ID: <Pine.LNX.3.96L.990913223653.9981F-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Sep 1999, Timothy Wall wrote:
> 
> I've run into an odd problem that I'm not quite sure how to diagnose.
> 
> My root partition  (a 2Gb partition on an 8Gb drive) shows (with "df")
> around 55% usage (2203440 1k-blocks, a little over half used) and yet
> fails complaining that the disk is full.   I don't recall exactly how I
> partitioned the disk (probably pdisk).
> 
> Is my ext2fs accounting screwed?  Why does the FS think there is no
> space when writing, but show space with "df" ?

Run 'df -i'. This shows you your inode usage. Full, isn't it? Time to backup,
reformat (with mke2fs), and reinstall.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
