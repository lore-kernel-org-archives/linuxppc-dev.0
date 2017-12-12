Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXT6fQLzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:21 +1100 (AEDT)
In-Reply-To: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: make use of for_each_node_by_name() instead of
 open-coding it
Message-Id: <3ywyXT1N4Qz9t3V@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 01:54:37 UTC, Dmitry Torokhov wrote:
> Instead of manually coding the loop with of_find_node_by_name(), let's
> switch to the standard macro for iterating over nodes with given name.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0aa8ff9b76282300d16e0a1403b115

cheers
