Message-ID: <39632512.1953DBAA@amulet.co.jp>
Date: Wed, 05 Jul 2000 21:07:46 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Andrew Clausen <clausen@gnu.org>
CC: linuxppc-dev@lists.linuxppc.org, GNU Parted list <parted@gnu.org>
Subject: Re: GNU Parted, linuxppc support coming :-)
References: <39625AB3.6A5447CE@gnu.org>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Clausen wrote:
>
> I'm trying to support the Mac partition map, but I'll need some help,
> since I don't have a PowerPC :-(

Just about everything you need is at
http://developer.apple.com/techpubs/mac/Devices/Devices-121.html#HEADING121-50

At least, I know that myself and a few other people have been able to
code based off of that.

> Could someone send me their partition map?  You can get this with:
>
>         # dd if=/dev/hda bs=512 count=MAP-SIZE | gzip | map.gz
>
> If you don't know how big your partition map (+1 for driver block) is,
> then 64 should do (?).  (What's a reasonable size for a partition
> map?)

I forget, but I don't think *anyone* has more than 20 (on most Macs, the
first 7 contain drivers etc), so 20 x sizeof(partition) (see above URL).

> Note: I'm not adding HFS support at this stage - it's a LOT of work.
> So you'll be able to resize ext2 partitions in the near future, but
> not HFS partitions :-/  Unless there are some volunteers...

There seems to be a shortage of HFS folks these days. :) But ext2
resizing sounds very cool.

-Hollis

P.S. Can't get you a real map right now, but email me later if you want
it.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
