Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7HX6lXbzF0XK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:00 +1100 (AEDT)
In-Reply-To: <20170201015438.18826-2-dmitry.torokhov@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] powerpc: make use of for_each_node_by_type() instead of
 open-coding it
Message-Id: <3zM7HX2lB3z9sPk@ozlabs.org>
Date: Thu, 18 Jan 2018 00:29:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 01:54:38 UTC, Dmitry Torokhov wrote:
> Instead of manually coding the loop with of_find_node_by_type(), let's
> switch to the standard macro for iterating over nodes with given type.
> 
> Also fixed a couple of refcount leaks in the aforementioned loops.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9625e69a3818cc00fd85632719b4c6

cheers
