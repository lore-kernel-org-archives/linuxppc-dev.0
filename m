Message-ID: <37805F68.9344722D@mpifr-bonn.mpg.de>
Date: Mon, 05 Jul 1999 09:31:52 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
Reply-To: ad@MPIfR-Bonn.MPG.de
MIME-Version: 1.0
To: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: BootX extension freezes MacOS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

	I run LinuxPPC R5 on my 7300/166, MacOS 8.1, BootX 1.1.1 with 2 scsi disks
which have partitions as follows:

Disk id #6: MacOS "root" (HFS), Linux root, Linux swap

Disk id #0: MacOS "data" (HFS+), Linux home (marked as HFS for mountx), Linux
usr

When I disable the BootX extension, everything works fine.  I can start Linux
from the BootX app, and if I enable mountx, I see my home partition on the MacOS
desktop (with mountx disabled, MacOS suggests to format the home partition).

With the BootX extension, I was able to boot Linux, but selecting MacOS, the
system freezes when building the desktop.  This happens with and without mountx
enabled.

Just as a test, I removed the disk #0 from the scsi chain --- and now everything
works fine with the extension!  Did I miss something important in the setup, or
is BootX somewhat broken if there is a HFS+ partition which is not the MacOS
"root"?

Thanks for your help, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
