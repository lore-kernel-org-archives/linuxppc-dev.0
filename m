Message-ID: <37DDA89E.8B35952D@tiac.net>
Date: Mon, 13 Sep 1999 21:45:02 -0400
From: Timothy Wall <twall@tiac.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: missing space on ext2fs scsi drive
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've run into an odd problem that I'm not quite sure how to diagnose.

My root partition  (a 2Gb partition on an 8Gb drive) shows (with "df")
around 55% usage (2203440 1k-blocks, a little over half used) and yet
fails complaining that the disk is full.   I don't recall exactly how I
partitioned the disk (probably pdisk).

Is my ext2fs accounting screwed?  Why does the FS think there is no
space when writing, but show space with "df" ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
