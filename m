Message-ID: <36CB7CF1.B53636AB@iwate-u.ac.jp>
Date: Thu, 18 Feb 1999 12:37:37 +1000
From: Piotr Muszynski <u0295020@iwate-u.ac.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: scsi drivers (Quantum Fireball problem)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

There's strong evidence to suspect that new kernels (after maybe
2.1.127/2.1.131) don't recognize specifically QuantumFireball 1.2GB HD,
the standard disk in PMacs 7200/7500 and perhaps 7600.
There are many people using these disks that have difficulties with new
kernels because of this problem.
I imagine it would be impossible to install r5 on original,  single-disk
PM7200/7500.

Is there anyone working on that?  If not,  I look for someone that knows
linuxppc's scsi drivers to help me isolate the trouble.  I have
PM7500/601/100 with QuantumFireball holding HFS (BootX) and IBM with
HFS/ext2,  running r4.

piotru

ps I know with today prices it's easy to change drives,  but ...



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
