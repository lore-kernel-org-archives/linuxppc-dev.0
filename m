From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBE27@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Linux] Problem with booting Linux
Date: Thu, 19 Jun 2003 11:19:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am working on Linux on a 860 target.
I use UBoot as bootloader & a BDI2000.

In Bdi, if I make
	reset run
	go
Then in Uboot
	bootm 0x43000000
Linux hangs when trying to start init.



In Bdi, if I make
	reset run
	halt
	go
Then in Uboot
	bootm 0x43000000
Linux works fine


It seems that the fact to make a halt before running makes the init works
!!!

Ever seen that ?
Ideas ?

Thanks

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
