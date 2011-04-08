Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E493EB6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 19:28:45 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p389ScVF011721
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 11:28:38 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Where is CONFIG_BOOT_LOAD ?
Date: Fri, 8 Apr 2011 11:28:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201104081128.37906.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I don't see this option in the .config and in the menuconfig / Advanced Setup I don't see a [Set the boot link/load 
address]:

[*] Prompt for advanced kernel configuration options
[ ]   Set maximum low memory
[ ]   Set custom page offset address
[ ]   Set custom kernel base address
[ ] Set custom user task size
[ ] Set custom consistent memory pool size
 
-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
