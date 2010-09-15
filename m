Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAC21B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 00:48:58 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8FEmqe6009036
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 16:48:53 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generating elf kernel ?
Date: Wed, 15 Sep 2010 16:51:06 +0200
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
In-Reply-To: <4C90835E.4050803@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009151651.06816.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Please use simpleImage.<your target dts name>.elf.

Great, that seems to be it...
Except that nothing happens when I jump to 0x40000, no message from the 
kernel, nothing.
I'm a bit stumped here as my old kernel worked fine.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
