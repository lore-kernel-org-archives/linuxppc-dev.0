Date: Mon, 24 May 1999 15:28:16 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: laures@esiea.fr
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Initio miles tests :-(
In-Reply-To: <199905241534.KAA24850@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.05.9905241526320.650-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 May 1999 laures@esiea.fr wrote:

> Each time the ext2 partition is completely screwed, I must reformat to
> continue tests, the hfs is screwed once over 2.
> I think I will go on with a ramdisk !

Can you do all the stress testing if you don't pdisk the drive?  Also can
you go:
pdisk /dev/blank-inito-disk
... create partitions ...
stress testing
?

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
