Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzW6xDBzDvhJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:11 +1100 (AEDT)
In-Reply-To: <1478013963-28871-3-git-send-email-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Johan Hovold <johan@kernel.org>
Subject: Re: [3/4] powerpc/vio: clarify vio_find_node reference counting
Message-Id: <3tHTzW4Zv3z9t3K@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-11 at 15:26:02 UTC, Johan Hovold wrote:
> Add comment clarifying that vio_find_node() takes a reference to the
> embedded struct device which needs to be dropped after use.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e8cfb7e7c3b2be8a4c2241b5da2ae6

cheers
