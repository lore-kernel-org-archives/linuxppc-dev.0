Return-Path: <Tiejun.Chen@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DDA16B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 13:20:26 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 65B56DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 13:20:26 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: powerpc/405ex: Support cuImage for PPC405EX
Date: Tue, 18 Aug 2009 10:28:02 +0800
Message-Id: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Summary: powerpc/405ex: Support cuImage for PPC405EX
Reviewers: Benjmain and linux-ppc
----------------------------------------------------
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
Bytes transferred = 1540945 (178351 hex)
=> bootm
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.31-rc5-57857-g8df7f47-
   Created:      2009-08-17   6:31:13 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1540881 Bytes =  1.5 MB
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

Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.1.2:/home/vividfe/rootfsf
Finalizing device tree... flat tree at 0x747300
Using PowerPC 40x Platform machine description
...

Best Regards
Tiejun
