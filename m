Message-ID: <19990510213309.43528@ibrium.se>
Date: Mon, 10 May 1999 21:33:09 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-user@lists.linuxppc.org
Subject: Mac-on-linux is now working...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Mac-on-linux is an open source emulator which 
runs Mac OS on linuxPPC machines. Since the
processor is running unemulated it is very fast
(about 95% according to speedometer specmarks
on a 8500).

Currently Mac OS boots on the 7200 and 8500
without a ROM-image. Other machines should be 
able to run the software using a ROM-image 
from one of those two computers (G3 machines may
or may not boot Mac OS).

Brief status summary:

video:		full-screen video working
mouse/keyboard:	working
scsi:		working
floppy:		working
sound:		not implemented
ethernet:	not implemented (yet)
serial:		hack allowing OF interaction

More information (and the source code) can be found 
at <http://www.ibrium.se/linux/mac_on_linux.html>.

The project could have use a few more developers, so
please join the mac-on-linux team!


/Samuel Rydh

-- 

----------------------------------------------------------
  E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
    Phone/fax: (home) +46 4418431, (work) +46 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
