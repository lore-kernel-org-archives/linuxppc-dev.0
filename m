Message-ID: <35C119252057D511BB9F0003476BF8A298BDB7@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS root using GT 64260 Ethernet...
Date: Mon, 21 Jan 2002 15:13:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am able to get Linux with ramdisk working on our custom board based on PPC
750 and GT64260 controller. I am able to ping outside network with Ethernet
1 of GT64260.

Now, I enabled NFS root file system. But it complains "No NFS server found"
etc. But I don't see any BOOTP requests going out of the GT 64260 Ethernet.
I am sure that the Ethernet driver is initialized before even NFS related
messages comes up.

Can some one help me out with this.

--Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
