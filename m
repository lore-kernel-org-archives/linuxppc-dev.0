Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id ED989DE060
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 09:58:17 +1100 (EST)
Received: by bwz3 with SMTP id 3so17982430bwz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Jan 2009 14:58:15 -0800 (PST)
Message-ID: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
Date: Sat, 3 Jan 2009 23:58:14 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Linux PPC" <linuxppc-dev@ozlabs.org>
Subject: 2.6.28 does not boot on MPC8315E-RDB, or...?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I cannot get my 2.6.28 kernel to boot. The board resets after u-boot
starts the kernel.

I would like to verify if someone got it booting already?

Regards,

Leon.


TFTP from server 192.168.1.24; our IP address is 192.168.1.15
Filename 'uImage-mpc8315e-rdb.bin'.
Load address: 0x400000
Loading: T #################################################################
         #################################################################
         #########
done
Bytes transferred = 2033899 (1f08eb hex)
Speed: 1000, full duplex
Using eTSEC0 device
TFTP from server 192.168.1.24; our IP address is 192.168.1.15
Filename 'uImage-mpc8315e-rdb.dtb'.
Load address: 0x700000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting image at 00400000 ...
   Image Name:   Angstrom/2.6.28/mpc8315e-rdb
   Created:      2009-01-03  22:44:25 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2033835 Bytes =  1.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x700000


U-Boot 1.3.0-rc2 (Oct  7 2008 - 11:57:25) MPC83XX



-- 
Leon
