Message-ID: <20010103152029.51915.qmail@web11108.mail.yahoo.com>
Date: Wed, 3 Jan 2001 07:20:29 -0800 (PST)
From: gopi krishna <mgopik@yahoo.com>
Subject: Problem with FEC on CLLF
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have a cllf board with MII port(uses qs6612 phy).

If we connect this to our switch *through a
hub*(100mbps half duplex), everything is working fine.

If we connect this directly to the switch, both the
switch and the cllf show the link status to be up and
connected(100mbps, half duplex), but ping doesnt work.

We have noticed that the switch recieves the
packets(frames) that the cllf is sending on the fec
port,  the switch is sending some frames to the cllf
fec port, but cllf doesnt receive even a single frame.

Any pointers to the possible problem/solution?

gopi
Tejas Networks India Ltd
Phone +91-80-2267495,Extn: 4044


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
