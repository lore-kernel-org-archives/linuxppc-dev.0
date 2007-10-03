Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 55917DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 23:29:30 +1000 (EST)
Date: Wed, 3 Oct 2007 17:30:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to
	the QE library
Message-ID: <20071003133032.GA2417@localhost.localdomain>
References: <11903212461510-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <11903212461510-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur,

On Thu, Sep 20, 2007 at 03:47:26PM -0500, Timur Tabi wrote:
> This patch makes numerous miscellaneous code improvements to the QE library.

...and also breaks MPC8568E-MDS. ;-) Board hangs just after ip-config stuff.

Commit 589ffa1c520355e37d5868 in galak/powerpc.git.

Unfortunately it isn't split, thus it will take time to track faulty bit.
But so far... maybe you have any ideas?

...
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:00:fd
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:01:fd
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
UCC Ethernet Controller MII Bus: probed
ucc_geth: QE UCC Gigabit Ethernet Controller
ucc_geth: UCC1 at 0xe0082000 (irq = 32)
ucc_geth: UCC2 at 0xe0083000 (irq = 33)
PCI: Enabling device 0001:02:00.0 (0000 -> 0003)
sky2 0001:02:00.0: v1.18 addr 0xa0000000 irq 18 Yukon-EC (0xb6) rev 1
sky2 eth4: addr 00:00:5a:71:75:fe
Marvell 88E1101: Registered new driver
Marvell 88E1112: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
netconsole: not configured, aborting
i2c /dev entries driver
rtc-ds1374 0-0068: rtc core: registered rtc-ds1374 as rtc0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
rtc-ds1374 0-0068: setting the system clock to 2007-01-02 22:23:42 (1167776622)
sky2 eth4: enabling interface
Sending DHCP requests .<6>PHY: e0024520:02 - Link is Up - 100/Full
PHY: e0024520:03 - Link is Up - 100/Full
PHY: e0024520:01 - Link is Up - 100/Full
., OK
IP-Config: Got DHCP answer from 10.0.0.2, my address is 10.0.0.99

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
