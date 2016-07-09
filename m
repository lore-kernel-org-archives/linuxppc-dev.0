Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rn5FY4WSTzDqwM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jul 2016 08:12:33 +1000 (AEST)
Date: Sat, 09 Jul 2016 18:06:40 -0400 (EDT)
Message-Id: <20160709.180640.648031801699853376.davem@davemloft.net>
To: arvind.yadav.cs@gmail.com
Cc: leoli@freescale.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Need proper type casting before assignment, Remove
 compilation Warning.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1467916674-8418-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1467916674-8418-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri,  8 Jul 2016 00:07:54 +0530

> -Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
> assigned in ucc_fast_tx_virtual_fifo_base_offset and
> ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'.
> So before assginment need a proper type casting.
> 
> -Passing value in IS_ERR_VALUE() is wrong, as they pass an 'int'
> into a function that takes an 'unsigned long' argument.This happens
> to work because the type is sign-extended on 64-bit architectures
> before it gets converted into an unsigned type.
> 
> -Passing an 'unsigned short' or 'unsigned int'argument into
> IS_ERR_VALUE() is guaranteed to be broken, as are 8-bit integers
> and types that are wider than 'unsigned long'.
> 
> -Any user will get compilation warning for that do not pass an
> unsigned long' argument.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Your subject line is improperly formed.

It must have the subsystem or driver name, followed by a colon ":"
and a space.  Such as:

	[PATCH] ucc_geth: Need proper type ...
