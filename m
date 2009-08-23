Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D97D5B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 23 Aug 2009 12:02:52 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: v1 powerpc/405ex: Support cuImage for PPC405EX
Date: Sun, 23 Aug 2009 10:03:42 +0800
Message-Id: <1250993024-29527-1-git-send-email-tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Summary: powerpc/405ex: Support cuImage for PPC405EX
Reviewers: Josh and linux-ppc
----------------------------------------------------
V1 patches are generated based on V0 as Josh's comments:
===
1. Remove duplicate #defines to merge 405EX with 440GX.
2. To prefix with ibm405ex_ for the related function.
3. Remove redundant comment for sysclk.

These patch series are used to support cuImage on the kilauea board based on PPC405ex.

Tested on the amcc kilauea board:
===
...
=> tftp 1000000 cuImage.kilauea
Waiting for PHY auto negotiation to complete.. done
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 192.168.1.2; our IP address is 192.168.1.103
Filename 'cuImage.kilauea'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #########################################
done
Bytes transferred = 1541019 (17839b hex)
=> bootm
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.31-rc5-57857-g2969260-
   Created:      2009-08-23   1:46:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1540955 Bytes =  1.5 MB
   Load Address: 00400000
   Entry Point:  00400468
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
CPU clock-frequency <- 0x23c345fa (600MHz)
CPU timebase-frequency <- 0x23c345fa (600MHz)
/plb: clock-frequency <- bebc1fe (200MHz)
/plb/opb: clock-frequency <- 5f5e0ff (100MHz)
/plb/opb/ebc: clock-frequency <- 5f5e0ff (100MHz)
/plb/opb/serial@ef600200: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x10000000> (256MB)
ethernet0: local-mac-address <- 00:06:4b:10:22:6c
ethernet1: local-mac-address <- 00:06:4b:10:22:6d

zImage starting: loaded at 0x00400000 (sp: 0x0fe9ec08)
Allocating 0x330c70 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040f000:0x0073a03c)...done 0x31425c bytes

Linux/PowerPC load: [...]
Finalizing device tree... flat tree at 0x747300
Using PowerPC 40x Platform machine description
Linux version 2.6.31-rc5-57857-g2969260-dirty ...

Best Regards
Tiejun
