Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kp65HPzDqy3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:26 +1000 (AEST)
In-Reply-To: <1467699155-19108-3-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: oss@buserror.net, geoff@infradead.org
Subject: Re: [3/3] powerpc/configs: remove old symbols from defconfigs
Message-Id: <3rp1Kp1NRSz9t1J@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 06:12:35 UTC, Andrew Donnellan wrote:
> Update defconfigs to remove old symbols and comments referencing old
> symbols.
> 
> Dropped:
> 
> * AVERAGE
> * INET_LRO
> * EXT3_DEFAULTS_TO_ORDERED
> * EXT3_FS_XATTR
> * I2O
> * INFINIBAND_AMSO1100
> * INFINIBAND_EHCA
> * IP1000
> 
> Replaced:
> 
> * BLK_DEV_XIP -> BLK_DEV_RAM_DAX
> * CLK_PPC_CORENET -> CLK_QORIQ
> * EXT2_FS_XIP -> FS_DAX
> * EXT3_FS* -> EXT4_FS*
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bdd910017c6a4d0a53e4e69d1b

cheers
