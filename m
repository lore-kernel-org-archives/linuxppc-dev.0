Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 89B98DDED0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:41:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] Remove bogus comment in dma_direct_alloc_coherent()
Date: Thu, 6 Dec 2007 00:41:48 +0100
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
	<d35bdbd4be04065ab67b93b7a6a876a000dc4cf1.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <d35bdbd4be04065ab67b93b7a6a876a000dc4cf1.1196839256.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060041.49223.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Michael Ellerman wrote:
> Since commit c80d9133e99de1af607314107910a2a1645efb17 (Make direct DMA use
> node local allocations) went in this comment makes no sense.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
