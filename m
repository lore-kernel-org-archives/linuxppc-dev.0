Message-ID: <39CA22CE.BD0804F1@gnu.org>
Date: Fri, 22 Sep 2000 02:01:34 +1100
From: Andrew Clausen <clausen@gnu.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: bug-parted@gnu.org
Subject: Please test GNU Parted's Mac support
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I would be very happy if a few of you went over Parted's Mac
partition map support :-)

ftp://ftp.gnu.org/gnu/parted/devel/parted-1.4.0-pre1.tar.gz

There are some things it can't do, that it should be able to do,
like "blessing" boot partitions... so, I need to figure out how
to document this stuff.  Since I don't have a ppc box, I'd
appreciate comments to help me write the docs...

Also: is there a special system name that is used to identify
RAID and LVM partitions?

Thanks!
Andrew Clausen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
