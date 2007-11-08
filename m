Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95D76DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 06:18:55 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IqCtu-0000ZE-Vi
	for linuxppc-dev@ozlabs.org; Thu, 08 Nov 2007 13:18:51 -0600
To: linuxppc-dev@ozlabs.org
Subject: DTS Bytestrings Representation in /dts-v1/ files
In-Reply-To: Your message of "Wed, 07 Nov 2007 08:14:29 CST."
	<E1Iplfp-0003WY-MB@jdl.com>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com>
Date: Thu, 08 Nov 2007 13:18:50 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IqCtu-0000ZE-Vi@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Folks,

When the new DTS /dts-v1/ support is released Real Soon Now,
it will support C-like literal constants.  Hex values will be
prefixed with 0x, binary with 0b, and bare numbers will be
decimal unless they start with a leading 0.

One outstanding question on which I'd like some feedback
is the issue of bytestring value representation.

Currently they look like this:

    stuff = [ 0b 31 22 de ea ad be ef ];

One opinion is to have them continue to look like that
and be in hex only.

Another opinion is to allow the new, consistent  C-style
literals and expressions so that one could have:

    new_stuff = [ 0x31 49 '1' 23 17 ];

Opinions?

Thanks,
jdl
