Message-ID: <39626E45.E0496869@gnu.org>
Date: Wed, 05 Jul 2000 09:07:49 +1000
From: Andrew Clausen <clausen@gnu.org>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@amulet.co.jp>
CC: linuxppc-dev@lists.linuxppc.org, GNU Parted list <parted@gnu.org>
Subject: Re: GNU Parted, linuxppc support coming :-)
References: <39625AB3.6A5447CE@gnu.org> <39632512.1953DBAA@amulet.co.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis Blanchard wrote:
>
> Andrew Clausen wrote:
> >
> > I'm trying to support the Mac partition map, but I'll need some help,
> > since I don't have a PowerPC :-(
>
> Just about everything you need is at
> http://developer.apple.com/techpubs/mac/Devices/Devices-121.html#HEADING121-50

Yeah, I've read it... :-)

> At least, I know that myself and a few other people have been able to
> code based off of that.

Yep.

> > Could someone send me their partition map?  You can get this with:
> >
> >         # dd if=/dev/hda bs=512 count=MAP-SIZE | gzip | map.gz
> >
> > If you don't know how big your partition map (+1 for driver block) is,
> > then 64 should do (?).  (What's a reasonable size for a partition
> > map?)
>
> I forget, but I don't think *anyone* has more than 20 (on most Macs, the
> first 7 contain drivers etc), so 20 x sizeof(partition) (see above URL).

Each partition gets one block (yes?).  So thats 20 * 512?
(From comments in various programs, most disks have 512 byte blocks...)

> > Note: I'm not adding HFS support at this stage - it's a LOT of work.
> > So you'll be able to resize ext2 partitions in the near future, but
> > not HFS partitions :-/  Unless there are some volunteers...
>
> There seems to be a shortage of HFS folks these days. :) But ext2
> resizing sounds very cool.

Excuse my ignorance... what FS's do people usually use with MacOS?
HFS/HFS+?

(Is the point "no-one uses MacOS", or "no-one's hacking on HFS
in Linux"?)

> P.S. Can't get you a real map right now, but email me later if you want
> it.

That would be useful, thanks :-)

Andrew Clausen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
