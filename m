Message-ID: <3B979787.8DC8E86@laposte.net>
Date: Thu, 06 Sep 2001 17:34:31 +0200
From: ibm405gp <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: ppp for Walnut 405GP
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I successfully compiled ppp-2.4.0 for my walnut board.
But each time, i start "pppd", i have the following messages :

[root@maquette405GP /]# pppd call dialout
mapped database of hash_size 128 map_size=8192
bad magic 0x00000000 in free list
tdb_allocate failed for size 17
tdb_store failed: Success
bad magic 0x00000000 in free list
tdb_allocate failed for size 33
tdb_store failed: Success
bad magic 0x00000000 in free list
tdb_allocate failed for size 23
tdb_store key failed: Success
bad magic 0x00000000 in free list
tdb_allocate failed for size 51
tdb_store failed: Success
bad magic 0x00000000 in free list
tdb_allocate failed for size 17
tdb_store key failed: Success
bad magic 0x00000000 in free list
tdb_allocate failed for size 63
tdb_store failed: Success
Dialling

I can dial-out with no problem, but i cant dial-in on my Walnut board.
I suppose it's due to the previous messages.
Does anyone met this pb ? (I'm running linux_2.4.2-mvista_010412 kernel)
Thanks

Phil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
