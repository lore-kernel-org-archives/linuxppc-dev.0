Date: Wed, 5 Jul 2000 13:01:58 -0700
From: Daniel Jacobowitz <drow@false.org>
To: Andrew Clausen <clausen@gnu.org>
Cc: Hollis Blanchard <hollis@amulet.co.jp>, linuxppc-dev@lists.linuxppc.org,
        GNU Parted list <parted@gnu.org>
Subject: Re: GNU Parted, linuxppc support coming :-)
Message-ID: <20000705130158.A18557@drow.them.org>
References: <39625AB3.6A5447CE@gnu.org> <39632512.1953DBAA@amulet.co.jp> <39626E45.E0496869@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39626E45.E0496869@gnu.org>; from clausen@gnu.org on Wed, Jul 05, 2000 at 09:07:49AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 05, 2000 at 09:07:49AM +1000, Andrew Clausen wrote:
> Each partition gets one block (yes?).  So thats 20 * 512?
> (From comments in various programs, most disks have 512 byte blocks...)

CDROMs, for example, often have 2048-byte blocks.  You can get the
block size out of the disk header somewhere, IIRC.

> > There seems to be a shortage of HFS folks these days. :) But ext2
> > resizing sounds very cool.
>
> Excuse my ignorance... what FS's do people usually use with MacOS?
> HFS/HFS+?

Yes, that's right.

> (Is the point "no-one uses MacOS", or "no-one's hacking on HFS
> in Linux"?)

The latter.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
