Return-Path: <enorm@126.com>
Received: from m15-112.126.com (m15-112.126.com [220.181.15.112])
	by ozlabs.org (Postfix) with SMTP id B749C67C61
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Sep 2006 21:39:16 +1000 (EST)
Message-ID: <003f01c6d012$79fa8dd0$a309a8c0@cdf28e684a26482>
From: "enorm" <enorm@126.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem about porting u-boot 1.1.4 to MPC8560
Date: Mon, 4 Sep 2006 19:08:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
    After prog u-boot image to 8560. We get output as follows:



U-Boot 1.1.4 (Sep  4 2006 - 17:15:31)

CPU:   8560, Version: 1.0, (0x80700010)
Core:  E500, Version:
Clock Configuration:- 19:56:59)
       CPU: 825 MHz, CCB: 330 MHz,, Version: 1.0, (0x80700010)
       DDR: 165 MHz, LBC:  82 MHzCore:  E500, Version: 1.0, (0x802
L1:    D-cache 32 kB enabled
Clock Confi
       I-cache 32 kB enabled
       CPU: 792 MHz, CCB: 2
Board: ADS
    PCI1: 32 bit, 33 MHz (compiled) MHz, LBC:  66 MHz
I2C:   ready
L1:    D
DRAM:  Initializing
 32 kB enabled
DDR: number of ranks = 1: ADS
    PCI1
DDR: DDR I rank density = 0x10000000
I2C:   rea

DDR: cs0_bnds   = 0x0000000fzing
DDR:
DDR: cs0_config = 0x80000102
DDR: DDR I r
DDR: caslat SPD bit is 4
DDR: tCKmin = 5000 psbnds   = 0x00000007
DDR: sdram_mode_2 = 0x00000000
DDR: sdram_interval = 0x05080100
DDR: sdram_cfg_2  = 0x00000000
DDR: sdram_cfg   = 0xc2000000
DDR: MAS0=0x10080000
DDR: MAS1=0xc0000900
DDR: MAS2=0x00000000
DDR: MAS3=0x00000015
DDR: LAWBAR1=0x00000000
DDR: LARAR1=0x80f0001b
    SDRAM: 64 MB
    DDR: 256 MB
Top of RAM usable for U-Boot at: 10000000
Reserving 173k for U-Boot at: 0ffd0000
Reserving 136k for malloc() at: 0ffae000
Reserving 88 Bytes for Board Info at: 0ffadfa8
Reserving 72 Bytes for Global Data at: 0ffadf60
Stack Pointer at: 0ffadf48



then it can't go on running. we checked ,found it falled in "relocate_code"
,then we write a progam to test memory, we found test failed(say write some
thing to 0-0x8000000 then read)



How can we do to fix this problem?
