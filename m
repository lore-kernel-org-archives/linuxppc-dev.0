Message-ID: <37DDAACA.FFBFF68D@execpc.com>
Date: Mon, 13 Sep 1999 20:54:18 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Timothy Wall <twall@tiac.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing space on ext2fs scsi drive
References: <37DDA89E.8B35952D@tiac.net>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Timothy Wall wrote:
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

I had this problem when i installed 1999 with it reformatting my drives.  The
problem is it didn't recognize the partition geom right.  My problem was i had a
2 gig partition, it was formatted as if it were 1 gig, and its max files were
only 65k of them.  So when i tried to have more then 65000+ files on this drive,
it still had space, but no blank table entries for the new files.  whoops.

Im not sure what caused it, but what i did was put the files on another
drive(s), reformat the drive (which did it right (?)), and move them back.  I'd
like to think there is a better solution.  Ideas?

Hope this helps.  Good luck.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
