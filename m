Mime-Version: 1.0
Message-Id: <p05100301b8bdb1fe0b79@[66.26.75.241]>
Date: Tue, 19 Mar 2002 22:32:19 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.19pre3 boot problem with ext SCSI
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is on a 6500 with an external SCSI (mesh) Yamaha CDRW. With
2.4.19pre3 I fall into the mon debugger during boot as long as the
CDRW is powered on (and no keyboard control, as usual for me with
mon). This does not happen with 2.4.18, both rsynced from
source.mvista.com::linuxppc_2_4. With the CDRW powered off (but still
connected), no boot freeze.

I want to remember someone ranting here about a simple mesh patch
that was again and again being not added to the tree, but I can no
longer find that message. Was thinking it might be my solution. Any
clues as to that patch?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
