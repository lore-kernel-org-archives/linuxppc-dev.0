Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 5449F2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Dec 2004 21:38:10 +1100 (EST)
Message-ID: <41C7FCF8.1060406@asist-traffic.com>
Date: Tue, 21 Dec 2004 11:37:44 +0100
From: ivica@asist-traffic.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20041220210226.E0438C1430@atlas.denx.de>
In-Reply-To: <20041220210226.E0438C1430@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: i2c on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:

>We did, in 2.4, where it works OK, at least as long as  the  hardware
>is OK (some of the earlier Icecube boards had some issues).
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
This is true. I get this output when I boot latest kernel from DENX.
I think I decided I will go to 2.6 because it had the preemptible kernel
option which I will probably need later on.
******************************************************
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-proc.o version 2.6.1 (20010830)
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
RAMDISK driver initialized: 16 RAM disks of 10240K size 1024 blocksize
loop: loaded (max 8 devices)
i2c-algo-5xxx.o: scanning bus Icecube I2C module #2 interface...
..................................................(0x32).............................(0x50)(0x51)(0x52)(0x53)(0x54)(0x55)(0x56)(0x57).......................................(0x)
i2c-icecube.o: I2C module #2 installed
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
*****************************************************

Root file system on NFS doesn't work though. I get this errors:
******************************************************
Looking up port of RPC 100003/2 on 192.168.254.58
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
*******************************************************

But this is not that big of a problem. I'll just boot stand alone images.
So, for writing a driver for my RTC i2c module I should look at
Documentation/i2c/writing-clients right?
And it should be under
[*] I2C Chips support  --->  right?

Best regards,
Ivica
