Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 3E802DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:49:47 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/11] celleb: add support for PCI Express
Date: Wed, 5 Mar 2008 12:49:28 +0100
References: <20080305.173919.1683988103.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.173919.1683988103.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051249.28739.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 March 2008, Ishizaki Kou wrote:
> This patch adds support for PCI Express port on Celleb. I/O space
> of this PCI Express port is not mapped in memory space. So we use
> the io-workaround mechanism to make accesses indirect.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

This one looks good, but I wonder if we should make it possible to
also use it on QS20, which the current code doesn't allow.

It's a rather hypothetical question, because QS20 has been replaced
by QS21 as a product and it never supported PCIe cards with I/O space
mappings, but it would be the "right" thing to do.

Since you don't have the QS20 hardware to test that, and I currently
doubt anyone at IBM has the energy to do the work, it will probably
never get done. If you send another version of the patch, maybe you
can add comments to hint that this is actually possible, just hasn't
been implemented.
