Message-ID: <388611CC.68CE63BC@execpc.com>
Date: Wed, 19 Jan 2000 13:34:36 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Network efficiency issue
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My wallstreet/300 has an issue with FTP transfers.  Incoming transfers work fine
at the full 10Mbit potential, however outgoing transfers are extremely slow,
around 75k/s.  This holds true of multiple server daemons and client apps.  I
have tried this against serveral computers, and it is consistent.  All file
transfers in the FTP protocol originating from my book are slow.  A switched hub
reported several collisions/sec when i tried using it, and this should not
happen.  NFS, etc seem to be unaffected by this issue/bug.

My best guess is that since FTP tends to be fairly raw and with little overhead,
this could be a flow control issue in the kernel.  I can supply my kernel
configuration if desired.  this occurs with a 2.2.14/Linus and a recent
2.3.39/Paul's Linuxcare rsync.

Any input would be greatly appreacated.  Thank you for your time.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
