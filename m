Return-Path: <Thomas.Hommel@gefanuc.com>
Received: from ext-ch1gw-3.online-age.net (ext-ch1gw-3.online-age.net
	[216.34.191.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 30A85DDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 22:33:51 +1000 (EST)
Received: from int-ch1gw-2.online-age.net (int-ch1gw-2 [3.159.232.66])
	by ext-ch1gw-3.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id l7VCPbeU009918
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:25:37 -0400 (EDT)
Received: from cinmlef06.e2k.ad.ge.com (int-ch1gw-2 [3.159.232.66])
	by int-ch1gw-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l7VCPapo025217
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 08:25:36 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Section mismatch in 2.6.23-rc4
Date: Fri, 31 Aug 2007 14:25:34 +0200
Message-ID: <62DDBB9E5E23CC4A929EE46F9427CEAF295F6F@BUDMLVEM04.e2k.ad.ge.com>
From: "Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When compiling a kernel, I get the warnings below.=20
I am using ARCH=3Dpowerpc and 'make mpc8641_hpcn_defconfig', 'make
uImage'. This didn't appear in 2.6.22, but in
arch/powerpc/kernel/head_32.S and setup_32.c, the section info
apparently didn't change.=20


  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x18): Section mismatch: reference to
.init.text:early_init (between '__start' and '__after_mmu_off')
WARNING: vmlinux.o(.text+0x3788): Section mismatch: reference to
.init.text:machine_init (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x3790): Section mismatch: reference to
.init.text:MMU_init (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x37ba): Section mismatch: reference to
.init.text:start_kernel (between 'start_here' and 'set_context')
WARNING: vmlinux.o(.text+0x37be): Section mismatch: reference to
.init.text:start_kernel (between 'start_here' and 'set_context')
  LD      vmlinux
  SYSMAP  System.map
