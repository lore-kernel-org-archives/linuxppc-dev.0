Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "aa aaa" <linux_powerpc@hotmail.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: jffs2 problem help!
Date: Thu, 22 Apr 2004 09:26:44 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY13-F46HY44cnNRxG0000368d@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


During creating jffs2 ,I modified the file /drive/mtd/maps/rpxlite.c just
like the file tqm8xxl.c,I refered the manual DULG.after loading and running
the kernel,display some following message:

init_rpxlite_mtd: chip probing count 0
request_module[cfi_cmdset_0002]: Root fs not mounted
Support for command set 0002 not present
cfi_probe: No supported Vendor Command Set found
init_rpxlite_mtd: chip probing count 1
request_module[cfi_cmdset_0002]: Root fs not mounted
Support for command set 0002 not present
cfi_probe: No supported Vendor Command Set found
init_rpxlite_mtd: chip probing count 2
request_module[cfi_cmdset_0002]: Root fs not mounted
Support for command set 0002 not present
cfi_probe: No supported Vendor Command Set found
init_rpxlite_mtd: chip probing count 3
request_module[cfi_cmdset_0002]: Root fs not mounted
Support for command set 0002 not present
cfi_probe: No supported Vendor Command Set found
RPXLITE: No support flash chips found!

Where is wrong? and when I use the commmand xd ,show no command,why?

thanks !!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
