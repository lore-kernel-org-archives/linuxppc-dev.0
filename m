Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9FC3B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 19:52:08 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8E8p0Ec013188
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2010 10:51:00 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Generating elf kernel ?
Date: Tue, 14 Sep 2010 10:53:11 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009141053.11946.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
In the past I've been using the PPC architecture to generate elf kernels (I 
wrote my own bootloader):
$ file zImage.elf 
zImage.elf: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 
(SYSV), statically linked, not stripped

I'm now trying to change to the PowerPC architecture, but the generated kernel 
is different and won't load:
$ file zImage
zImage: u-boot/PPCBoot image

How do I generate an elf file ?
For what it's worth, I use the Xilinx-patched kernel and I load it to a flash 
mem using impact.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
