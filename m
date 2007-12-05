Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 4F40CDDE49
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:41:17 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/7] Have celleb use its own dma_direct_offset variable
Date: Thu, 6 Dec 2007 00:41:11 +0100
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
	<2b8d160d8baf8570781441808cd117dd5e34f703.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <2b8d160d8baf8570781441808cd117dd5e34f703.1196839256.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060041.11976.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Michael Ellerman wrote:
> Rather than using the global variable, have celleb use its own variable to
> store the direct DMA offset.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Arnd Bergmann <arnd@arndb.de>
