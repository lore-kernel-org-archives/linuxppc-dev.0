Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgk2768zF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:30 +1000 (AEST)
In-Reply-To: <1527765086-19873-21-git-send-email-xieyisheng1@huawei.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, <linux-kernel@vger.kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, andy.shevchenko@gmail.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,20/21] powerpc/xmon: use match_string() helper
Message-Id: <40zxgj5Kw4z9s1B@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-31 at 11:11:25 UTC, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0abbf2bfdc9dec32e9832aa8d4522a

cheers
