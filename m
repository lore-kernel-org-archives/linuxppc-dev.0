Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030908145948.75210.qmail@web41410.mail.yahoo.com>
Date: Mon, 8 Sep 2003 07:59:48 -0700 (PDT)
From: Jeff Stevens Stevens <jsteve17@yahoo.com>
Subject: Problems with EP862 and ELDK
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone have PPCBoot and ELDK up an running on an
EP862 board?

I have PPCBoot working with SDRAM and Flash, but when
I compile it to read the environment variables from
the EEPROM, it won't boot.  Does anyone have this
working?

I can however get it to boot if I compile it to get
its environment variables from flash (it just
complains and then loads some defaults).  However,
when I TFTP ELDK over to the EP862 and "GO 00400000",
it complains.

Here is the screen dump:

U-Boot 0.4.0 (Sep  5 2003 - 11:59:56)

CPU:   XPC855xxZPnnD4 at 48 MHz: 4 kB I-Cache 4 kB
D-Cache FEC present
Board: SBC 855 M EP862-1.1
I2C:   ready
DRAM:  16 MB
FLASH:  8 MB
env_relocate[205] offset = 0x4fe0000
env_relocate[223] malloced ENV at 00fb8008
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
=> tftp 00400000 zImage.eldk
TFTP from server 198.30.206.97; our IP address is
198.30.206.218
Filename 'zImage.eldk'.
Load address: 0x400000
Loading: #####
done
Bytes transferred = 25384 (6328 hex)
=> go 400000
## Starting application at 0x00400000 ...
loaded at:     00400000 0040C57C
board data at: 004001B8 004001D4
relocated to:  00200100 0020011C
zimage at:     00407000 004974CB
avail ram:     00498000 01000000

Linux/PPC load:
Uncompressing Linux...bad gzipped data
exit


What is the proper way to create the zImage for
PPCBoot (U-Boot)?


Thanks in advance,
 Jeff Stevens
 Software Engineer
 Systran Corporation


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
