Message-ID: <37AAB635.D2C1F0BF@mpifr-bonn.mpg.de>
Date: Fri, 06 Aug 1999 12:17:25 +0200
From: Albrecht Dre_ <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
CC: Paul.Mackerras@cs.anu.edu.au
Subject: 2.2.x kernels: Sound Bug report
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In kernels 2.2.6 and 2.2.10 I noticed a small flaw in sound support on a
PowerBook G3 (Wallstreet).  CD to sound (AWACS) playthrough is not enabled
regardless of the setting in the MacOS control panel.  This problem emerges when
booting with the BootX extension, but NOT if booting with the BootX application
(both ver. 1.1.1).  As Ben explained, MacOS seems to do some initialisation
which is not present in the Linux sound driver.

Thanks, Albrecht.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
