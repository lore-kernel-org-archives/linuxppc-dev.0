Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: hangs after "Freeing unused kernel memory"
Date: Thu, 15 Nov 2007 16:00:09 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This sounds like a familiar problem, but could not get answers in posts
that came up in google search.

My system hangs after printing the message "Freeing unused kernel
memory". It should execute init after that, but not sure what exactly is
happening. Appreciate if some one can throw few ideas to try out.

Seems it is actually hanging when it makes the call "
run_init_process(ramdisk_execute_command)" in init/main.c

System: 8641D
Kernel: 2.6.19

Vitesse VSC8244: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
bus pci: add driver ALI15x3_IDE
bus ide: add driver ide-disk
bus ide: add driver ide-cdrom
bus scsi: add driver sd
bus pci: add driver ahci
bus platform: add driver fsl-i2c
bus i2c: add driver eeprom
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Freeing unused kernel memory: 140k init

Thanks
Siva
