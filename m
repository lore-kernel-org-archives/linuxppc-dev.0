Message-ID: <40168C3E.7010903@g-house.de>
Date: Tue, 27 Jan 2004 17:05:18 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc trees / BK help
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hello,

after reading the recent threads about the different ppc trees (and much
BK stuff i still have to learn) i am still wondering if there are CVS
trees from say 2.4.24-benh or linuxppc-2.5-benh available.

there is a BK2CVS gateway, but my cloning always results only in
"strange trees". as seen on http://penguinppc.org/dev/kernel.shtml i do

bk clone bk://source.mvista.com/linuxppc-2.5-benh linuxppc-2.5-benh-BK

after passing the consistency check, a sourcetree shows up  but
filenames are different from normal:

evil@sheep:/data/MP3/scratch/kernel$ ls linuxppc-2.5-benh-BK/
BitKeeper  Documentation  SCCS  arch  crypto  drivers  fs  include  init
~ ipc  kernel  lib  mm  net  scripts  security  sound  usr
evil@sheep:/data/MP3/scratch/kernel$

- --> there are no files in the directory, only dirs.

evil@sheep:/data/MP3/scratch/kernel$ ls -w10 linuxppc-2.5-benh-BK/kernel/
SCCS
power
evil@sheep:/data/MP3/scratch/kernel$

yes, there are files somewhere too, e.g.

linuxppc-2.5-benh-BK/sound/pci/cs46xx/SCCS/s.dsp_spos.h

is there, but it is some kind of changelog or so. as you can imagine,
compiling fails :-(

someone there to enlighten me what´s going on here?

Thank you,
Christian.
- --
BOFH excuse #259:

Someone's tie is caught in the printer, and if anything else gets
printed, he'll be in it too.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
