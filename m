Message-Id: <199905242203.RAA30209@lists.linuxppc.org>
Date: Tue, 25 May 1999 00:02:46 +0200 (CEST)
From: laures@esiea.fr
Subject: Re: Initio miles tests :-(
To: tmrini@ntplx.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.9905241526320.650-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 24 Mai, Tom Rini wrote:
> 
> 
> Can you do all the stress testing if you don't pdisk the drive?  Also can
What I did: partitionned the disk under MacOs, two hfs, the second
mke2fsck'ed in linux after insertion of the module.
That's basically what I'm always doing, see below why.

> you go:
> pdisk /dev/blank-inito-disk
> ... create partitions ...
This is not possible since pdisk reports a incredible number of 512
bytes block for a 256M disk (the test drive), with a total free space
of 126G!!!
Here pdisk fail at creating the partition map, and at modifying it
sjightly.
I wish I could show you the output of pdisk, is it possible to redirect
output on a file, still setting the keyborad as input ?

Thx for your help :-)


-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
