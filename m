Date: Wed, 24 Oct 2001 05:19:29 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian PowerPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot-1.3.5pre1 Please test
Message-ID: <20011024051929.A15844@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This version fixes some problems with large disks and partitions which
use XFS or Reiserfs filesystems.

Yaboot also now fully supports ext3, even when the filesystem has not
been unmounted cleanly and thus requires recovery.  Previously yaboot
would only be able to read ext3 filesystems which were cleanly
unmounted (and thus ext2 compatible).

Please test and report any problems to me, I plan to release 1.3.5
this weekend most likely.  ext2/ext3 testing is most needed.

http://master.penguinppc.org/projects/yaboot/1.3.5pre/

pre1:
	- XFS fixes for large partitions (Brendan O'Dea)
	- Upgrade libext2fs to 1.25, this adds full ext3 support to yaboot.
	- Reiserfs fixes (Jeff Mahoney)

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
