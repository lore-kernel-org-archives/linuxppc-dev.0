Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70146BDFD@sr-bng-exc01.int.tsbu.net>
From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: SMP NFS issue while mounting ramdisk
Date: Sat, 20 Dec 2003 14:50:31 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

SMP NFS issue while mounting.
There is a problem with  supporting NFS in SMP(Symmetric MultiProcessor)
mode for MPC 7447 processor(with controller MV 64360) based PMC board.
It works fine in following cases { In both the cases ramdisk used is same }
	1)Without NFS support
	2)Single processor with NFS
When SMP and NFS are enabled it's behavior is inconsistent( After finding
the ramdisk some times it comes up to prompt and mounts file system as read
only, some times it will hang somewhere after giving message "Initializing
random number generator... done."

I tried with disabling the cache, which was main suspect.But problem remains
same.
Need to dig in to some thing else?????



Thanks,
Ashok


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
