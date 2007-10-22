Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 6BED8DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 21:05:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Difference between ioremap() and phy_to_virt() Kernel function
Date: Mon, 22 Oct 2007 13:04:43 +0200
References: <13339930.post@talk.nabble.com>
In-Reply-To: <13339930.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710221304.44275.arnd@arndb.de>
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

On Monday 22 October 2007, Misbah khan wrote:
> Could you Please let me know what is the difference between ioremap() and
> phy_to_virt() function being provided by the Kernel.

ioremap gives you a new mapping for I/O addresses that you can access
with functions like in_be32 and the like.

phy_to_virt() is rarely used at all, it only serves to convert a physical
address for main memory (RAM) into the address used inside of the kernel.

	Arnd <><
