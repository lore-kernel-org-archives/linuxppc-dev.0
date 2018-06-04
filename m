Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfs0yYgzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:45 +1000 (AEST)
In-Reply-To: <20180425112707.16392-1-yuehaibing@huawei.com>
To: YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <geoff@infradead.org>, <joe@perches.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/xics: add missing of_node_put() in error path
Message-Id: <40zxfr2Pzrz9s4Y@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-25 at 11:27:07 UTC, YueHaibing wrote:
> The device node obtained with of_find_compatible_node() should be
> released by calling of_node_put().  But it was not released when
> of_get_property() failed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/589b1f7e4b0db4c31cef3b55f75148

cheers
