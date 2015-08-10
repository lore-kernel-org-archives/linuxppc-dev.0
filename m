Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D5171A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:00 +1000 (AEST)
In-Reply-To: <1429186730-20723-1-git-send-email-weiyj_lk@163.com>
To: weiyj_lk@163.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Wolfram Sang <wsa@the-dreams.de>,
 Alexander Gordeev <agordeev@redhat.com>,
 Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>,
 Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/4xx: Fix return value check in hsta_msi_probe()
Message-Id: <20150810092700.424571402D8@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-16-04 at 12:18:50 UTC, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the functions platform_get_resource() and kmalloc()
> returns NULL not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35a7f41cc6bb7013e344

cheers
