Message-Id: <200008022120.WAA28609@hyperion.valhalla.net>
Date: Wed, 02 Aug 2000 22:20:29 +0100
Subject: 2.4.0-t5 lockup on shutdown.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know the cause of the (sometimes) complete lock-up of 2.4.0-t5
when shutdown & restart is selected from run level 5?

Observations/Symptoms:

the switch of VC occurs OK
Then *zilch*.  No panic, no response to SysRq keys... no response to
telnet...  three finger salute is the only way I've found out of it.

bk-tree  (linuxppc_2_3) as of 19:00 (BST) today. (but it's been happening on
& off with the 2.4.0 tree since I've been trying it).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
