Message-ID: <366C4624.84A1E42A@austin.cc.tx.us>
Date: Mon, 07 Dec 1998 15:18:28 -0600
From: Luyseyal <luyseyal@austin.cc.tx.us>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: lockups in 129 on pmac 6500
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i have a pmac 6500/225 (603ev) running an almost stock linuxppc. 2.1.127
worked
fine (except the annoying speaker bug), but apparently the PPC update in
129 killed 
something. regardless of configuration, it locks up right after it
parses the Open 
Firmware device tree.

i'm not on this list, so please write me directly or CC.
also, i'm not a developer, so if you want a bug report you'll have to
explain how to generate one for a kernel (i've only used gdb on a few
minor prog's).


thanks,

-l
--
By the way, ALL software projects are done by iterative prototyping.
Some companies call their prototypes "releases", that's all.

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GAT d- s+:- a-- C++$ UL(++++)>$ P L++ E--- W++ N-- !o !K w(---) !O M(--)
!V PS--(+++) PE Y+ PGP- t+* !5 X(-) R(*)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
