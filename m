Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3D6FB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 19:50:27 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p2P8oKur019813
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2011 09:50:20 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Early kernel debugging
Date: Fri, 25 Mar 2011 09:50:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201103250950.20423.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
what can you do when the kernel you try to run stops before printing anything on the console ?

I tried enabling the 'early printk' option, but still I get nothing.

I posted something about it in the 'Booting with ramdisk in kernel' message and I haven't improved the situation since 
then, although I found the CONFIG_BLK_DEV_RAM option.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
    "Freedom is just chaos, with better lighting."
