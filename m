Date: Sun, 23 Sep 2001 23:09:24 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
In-Reply-To: <20010923154607.A14835@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0109232307500.13300-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 23 Sep 2001, Ethan Benson wrote:

> is it possible you have an x86 BIOS partition table on that disk as
> well?  if mac-fdisk -l doesn't work then your mac partition table is
> corrupt.  but if that does work but the kernel is getting other ideas
> about your partitions you probably have both an x86 and mac partition
> table (its actually possible for them to coexist, but its a gross and
> uneeded hack).  what does /proc/partitions say?

But if the Mac partition table were corrupt, wouldn't it also be
skewed under my 2.2.18 Kernel as well?

Can't make heads or tails of it (I don't know what the columsn mean)
but here it is:

major minor  #blocks  name

   8     0    8971292 sda
   8     1         31 sda1
   8     2         27 sda2
   8     3         37 sda3
   8     4        100 sda4
   8     5        256 sda5
   8     6        256 sda6
   8     7    2661427 sda7
   8     8    5714420 sda8
   8     9     594722 sda9
   8    10          9 sda10
   8    16    4194157 sdb
   8    17         31 sdb1
   8    18         64 sdb2
   8    19    2000000 sdb3
   8    20    2194040 sdb4
   8    21         21 sdb5


--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
