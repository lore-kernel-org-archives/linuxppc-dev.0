Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <Christophe.LINDHEIMER@fr.thalesgroup.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [Linux] Problem with booting Linux
Date: Thu, 19 Jun 2003 17:24:25 +0800
Message-ID: <000101c33644$93872710$0200a8c0@john>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <D96E2AFA0DF3D211B139009027454948034CBE27@helios.gnv.tcc.thomson-csf.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


do you have any FPGA or CPLD on your board. if it is, your kernel should have delay time before loading FPGA or CPLD image. Maybe halt has completed this action.


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Christophe.LINDHEIMER@fr.thalesgroup.com
Sent: Thursday, June 19, 2003 5:19 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Linux] Problem with booting Linux



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
