Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5A5A0DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 19:17:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Difference between ioremap() and phy_to_virt() Kernel function
Date: Tue, 23 Oct 2007 11:11:42 +0200
References: <13339930.post@talk.nabble.com> <200710221304.44275.arnd@arndb.de>
	<13357088.post@talk.nabble.com>
In-Reply-To: <13357088.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710231111.43062.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 23 October 2007, Misbah khan wrote:
> But i wish to know that could i use phy_to_virt() function in place io
> ioremap() ?????

Sorry to disappoint you there, but you can't.

> And could you give me an example where we could use phy_to_virt().

Not really, I can't think of any correct use of phys_to_virt on powerpc.

	Arnd <><
