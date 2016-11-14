Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzQ1wvLzDvmL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:06 +1100 (AEDT)
In-Reply-To: <1478013963-28871-1-git-send-email-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Johan Hovold <johan@kernel.org>
Subject: Re: [1/4] ibmebus: fix device reference leaks in sysfs interface
Message-Id: <3tHTzQ16sXz9t1d@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-11 at 15:26:00 UTC, Johan Hovold wrote:
> Make sure to drop any reference taken by bus_find_device() in the sysfs
> callbacks that are used to create and destroy devices based on
> device-tree entries.
> 
> Fixes: 6bccf755ff53 ("[POWERPC] ibmebus: dynamic addition/removal...)
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fe0f3168169f7c34c29b0cf0c489f1

cheers
