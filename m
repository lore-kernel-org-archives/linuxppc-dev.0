Message-ID: <39625AB3.6A5447CE@gnu.org>
Date: Wed, 05 Jul 2000 07:44:19 +1000
From: Andrew Clausen <clausen@gnu.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: GNU Parted list <parted@gnu.org>
Subject: GNU Parted, linuxppc support coming :-)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've started hacking on linuxppc (on Macs) support for GNU Parted, a
partition program.  It's like fdisk (or pdisk), but it can also
create, copy and resize file systems that it has special support for.
More info at:

	www.gnu.org/software/parted

I'm trying to support the Mac partition map, but I'll need some help,
since I don't have a PowerPC :-(

Could someone send me their partition map?  You can get this with:

	# dd if=/dev/hda bs=512 count=MAP-SIZE | gzip | map.gz

If you don't know how big your partition map (+1 for driver block) is,
then 64 should do (?).  (What's a reasonable size for a partition
map?)

Note: I'm not adding HFS support at this stage - it's a LOT of work.
So you'll be able to resize ext2 partitions in the near future, but
not HFS partitions :-/  Unless there are some volunteers...

Of course, I'd also be happy very if someone could help with the code,
or just testing :-)

Thanks!
Andrew Clausen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
