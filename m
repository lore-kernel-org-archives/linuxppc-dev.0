Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 841A6B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 02:52:18 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB8FqDl3021466
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Dec 2010 16:52:13 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Wed, 8 Dec 2010 16:52:13 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012081118.13977.dargaud@lpsc.in2p3.fr>
	<1291815910.12093.15.camel@concordia>
In-Reply-To: <1291815910.12093.15.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012081652.13209.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Sorry I assumed you were working on mainline. In 2.6.35 you still need
> to use an of_platform_driver, I'll describe below.

> So basically you need to change all occurrences of platform_driver to
> of_platform_driver.

OK, thanks, I did that, compiled and ran the driver and its test prog... no 
changes: xad_driver_probe() doesn't get called.
...?

-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
