Date: Thu, 25 Oct 2001 05:29:57 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian PowerPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot-1.3.5pre2 Please test
Message-ID: <20011025052957.A18788@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The message= configuration option makes yaboot read the specified
filename and print its contents to the screen after init-message and
before the boot: prompt.  This could be quite useful for distros
making bootable CDs so they may include some brief instructions for
users.

Please test and report any problems to me, I plan to release 1.3.5
this weekend most likely.  ext2/ext3 testing is most needed.

http://master.penguinppc.org/projects/yaboot/1.3.5pre/

pre2:
	- Implement the message= configuration option (see yaboot.conf man page).

pre1:
	- XFS fixes for large partitions (Brendan O'Dea)
	- Upgrade libext2fs to 1.25, this adds full ext3 support to yaboot.
	- Reiserfs fixes (Jeff Mahoney)


--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
