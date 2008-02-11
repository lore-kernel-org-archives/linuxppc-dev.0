Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54F31DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 04:57:24 +1100 (EST)
Message-ID: <47B08C76.3000009@freescale.com>
Date: Mon, 11 Feb 2008 11:57:10 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com> <200802100647.56590.arnd@arndb.de>
In-Reply-To: <200802100647.56590.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> Maybe we can introduce a more generic way of having conditional
> device nodes in the tree that get knocked out in the boot wrapper.

I've been thinking about doing just this for quite some time now.  I've had a 
few informal discussions without people about.

One idea is to allow attaching simple conditional expressions (like X is <, =, 
or > than Y) to a node.  It is the responsibility of the code that parses the 
device tree to assign values to X and Y.  For instance, they could be the names 
of U-Boot environment variables.  If the expression is false, then the node is 
removed (or ignored) from the device tree.  If it's true, then it's kept in.

-- 
Timur Tabi
Linux kernel developer at Freescale
