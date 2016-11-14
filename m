Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzX5bhTzDvk4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:12 +1100 (AEDT)
In-Reply-To: <1478013963-28871-4-git-send-email-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Johan Hovold <johan@kernel.org>
Subject: Re: [4/4] powerpc/pci: fix device reference leaks
Message-Id: <3tHTzX3F2sz9t1d@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-11 at 15:26:03 UTC, Johan Hovold wrote:
> Make sure to drop any device reference taken by vio_find_node() when
> adding and removing virtual I/O slots.
> 
> Fixes: 5eeb8c63a38f ("[PATCH] PCI Hotplug: rpaphp: Move VIO...")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/99e5cde5eae78bef95bfe7c16ccda8

cheers
