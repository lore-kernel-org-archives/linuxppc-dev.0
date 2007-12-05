Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 698A6DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:40:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/7] Add celleb_dma_dev_setup()
Date: Thu, 6 Dec 2007 00:40:27 +0100
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
	<f4d0ac13491bbe6834fe1f8d4bf86c04754f3774.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <f4d0ac13491bbe6834fe1f8d4bf86c04754f3774.1196839256.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060040.28256.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Michael Ellerman wrote:
> Celleb always uses dma_direct_ops, and sets dma_direct_offset, so it too
> should set dma_data to dma_direct_offset.
> 
> Currently there's no pci_dma_dev_setup() routine for Celleb so add one.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
