Message-ID: <000b01c0b053$f8387e80$8021690a@huawei.com>
From: "dony" <dony.he@huawei.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Device lo is down...
Date: Mon, 19 Mar 2001 17:07:05 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

    This is my linux booting messages...

################################
................................
eth0: FCC ENET Version 0.2, 00:e0:fc:20:00:01
fec: Phy @ 0x0, type 0x00000000
fec: Phy @ 0x1, type 0x00000000
..........
fec: Phy @ 0x1e, type 0x00000000
fec: Phy @ 0x1f, type 0x00000000
IP-Config: Guessing netmask 255.0.0.0
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 10.105.35.35
Device lo is down.
Device lo is down.
#############################

At this point it should mount root fs via NFS, but it failed.
I am sure my NFS settings is OK.

 I use linux-2.4.0.

Any ideas?

Thank you very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
