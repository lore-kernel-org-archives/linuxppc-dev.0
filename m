Content-Type: text/plain;
  charset="iso-8859-1"
From: Rick Cook <rcook@ntlug.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: 9.1 Gbyte SCSI Drive
Date: Thu, 26 Apr 2001 00:07:14 -0500
MIME-Version: 1.0
Message-Id: <01042600071402.07811@p7300>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have a Power Macintosh 7300/200 that currently has two 2 Gbyte SCSI Hard
Drives run Debian 2.2 with partitions mounted from both drives. Everything is
working.

I have a Seagate 9.1 Gbyte SCSI ST39173LC that I would like to install as a
replacement for one of the 2 Gbyte drives. The dreaded "the 9.1 Gbyte drive
works fine in a Pentium 120 system". However, when I install it into the
7300, the system crashes when I attempt to mke2fs any of the partitions (I
have tried several partition size combinations). I don't remember if I have
tried this since I initialized the partition map on the Pentium Machine.

Is this a known problem in the powerpc kernel (I seem to remember a
relatively recent CVS log post for the Macintosh version of m68k about a
change related to this)?

Any suggestions about where to start looking?

Thanks,

Rick Cook
--
rcook@ntlug.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
