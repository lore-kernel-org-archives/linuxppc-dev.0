Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7FF34DDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:41:40 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/7] Remove the global dma_direct_offset
Date: Thu, 6 Dec 2007 00:41:32 +0100
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
	<854cf7522a012469ff1af0b90e874cb96c4d1a37.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <854cf7522a012469ff1af0b90e874cb96c4d1a37.1196839256.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060041.32572.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Michael Ellerman wrote:
> We no longer need the global dma_direct_offset, update the comment to
> reflect the new reality.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
