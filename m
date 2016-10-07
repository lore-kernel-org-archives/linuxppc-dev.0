Return-Path: <hkallweit1@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sqywW5qJGzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 16:38:03 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id b201so13669988wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Oct 2016 22:38:03 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Oliver O'Halloran <oohall@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
Date: Fri, 7 Oct 2016 07:37:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit results in boot stopping after the following messages.
Any additional information I could provide?


U-Boot 2010.12-svn19826 (Apr 24 2013 - 20:01:21)

CPU:   P1014, Version: 1.0, (0x80f10110)
Core:  E500, Version: 5.1, (0x80212151)
Clock Configuration:
       CPU0:800  MHz,
       CCB:400  MHz,
       DDR:333.333 MHz (666.667 MT/s data rate) (Asynchronous), IFC:100  MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: P1014RDB
SPI:   ready
DRAM:  128 MiB
L2:    256 KB enabled
Using default environment

PCIe1: Root Complex of mini PCIe Slot, x1, regs @ 0xffe0a000
  01:00.0     - 168c:abcd - Network controller
PCIe1: Bus 00 - 01
PCIe2: Root Complex of PCIe Slot, x1, regs @ 0xffe09000
  03:00.0     - 168c:0033 - Network controller
PCIe2: Bus 02 - 03
In:    serial
Out:   serial
Err:   serial
Net:   initialization for Atheros AR8327/AR8328
eTSEC1
auto update firmware: is_auto_upload_firmware = 0!
Autobooting in 1 seconds
SF: Detected S25FL128S_64K with page size 256, total 16 MiB
16384 KiB S25FL128S_64K at 0:0 is now current device
SPI flash read successful
SPI flash read successful
## Booting kernel from Legacy Image at 02000000 ...
   Image Name:   Linux-4.9.0-rc0
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2009549 Bytes = 1.9 MiB
   Load Address: 01000000
   Entry Point:  01000524
   Verifying Checksum ... OK
## Flattened Device Tree blob at 03000000
   Booting using the fdt blob at 0x3000000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 00ffa000, end 00ffffff ... OK
