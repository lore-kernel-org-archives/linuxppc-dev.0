Date: Sun, 23 Sep 2001 00:21:37 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <Pine.LNX.4.21.0109230013490.706-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To continue with 2.4.10-pre12 problems..

(This is a 2.4.9 with the 2.4.10-pre12 patch applied, everything
downloaded from ftp.kernel.org)

I've currently got two SCSI drives on my system.  /dev/sda is my dedicated
Linux drive, and /dev/sdb is my shared drive between Linux and
MacOS.  /dev/sda runs off of an Adaptec 2940UW card and /dev/sdb off of
the internal MESH of the PowerMac 8500.

If I try to do a

 mount -t hfs /dev/sdb3 /mnt/macos
 or
 mount /dev/sdb3 /mnt/macos

I get a message:

mount: /dev/sdb3 has wrong major or minor number

In addtion, if I issue:

pdisk -l /dev/sdb

I get a message:

pdisk: Can't read block 0 from '/dev/sdb'

Any ideas?

(BTW: This is not a hardware problem.  If I reboot with 2.2.18 everything
works fine).

--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
