Message-ID: <38E6B0BF.1A3FECC5@execpc.com>
Date: Sat, 01 Apr 2000 20:30:23 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: PRAMBoot Selector - update
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I spend some time with different devices on my powerbook, found there were some
huge gaps in the code i released.  I have released an update, and this time it
should work much better, and make more sense.  I think I have decoded the
meaning to the extent of how it effects my powerbook.  Changes can be made to
the boot selections by editing the .h file.

can be gotten at http://www.execpc.com/~jpgarcia

Any feedback/updates welcome.  Im more concerned with correctness than the
interface.  Next, I plan on implementing a partition map scan to find all
possible bootables, like MacOS does, but have little idea yet on how to do it.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
