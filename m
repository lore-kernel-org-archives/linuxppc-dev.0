Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3FC1FDE0F3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 21:09:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Select PCI for IBM_CELL_BLADE AND CELLEB
Date: Thu, 23 Apr 2009 13:07:00 +0200
References: <cf386cee8d45e3aac21cfc8af3dc17c5335c516b.1240476177.git.michael@ellerman.id.au>
In-Reply-To: <cf386cee8d45e3aac21cfc8af3dc17c5335c516b.1240476177.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904231307.00726.arnd@arndb.de>
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	randy.dunlap@oracle.com, subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 April 2009, Michael Ellerman wrote:
> Currently PPC_CELL_NATIVE selects PPC_OF_PLATFORM_PCI, but does not
> select PCI. This can lead to a config with the former and the latter
> disabled, which does not build.
> 
> To fix this PPC_CELL_NATIVE should select PCI. However, that would
> force PCI on for QPACE, which also selects PPC_CELL_NATIVE. So
> instead move the select of PPC_OF_PLATFORM_PCI and PCI under both
> IBM_CELL_BLADE and CELLEB.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Yes, this one looks right, thanks for following up on this.

Acked-by: Arnd Bergmann <arnd@arndb.de>
