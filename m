Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03ED61A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 12:01:23 +1100 (AEDT)
Message-ID: <1422838882.11325.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: remove redundant increment of hwirq
From: Michael Ellerman <mpe@ellerman.id.au>
To: Colin King <colin.king@canonical.com>
Date: Mon, 02 Feb 2015 12:01:22 +1100
In-Reply-To: <1422826808-31363-1-git-send-email-colin.king@canonical.com>
References: <1422826808-31363-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-02-01 at 21:40 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Recent commit 80fa93fce37d3490f
> ("cxl: Name interrupts in /proc/interrupt") introduced a
> redundant increment of hwirq which is not used or even
> initialised at the point it is incremented. Detected by
> cppcheck:
> 
> [drivers/misc/cxl/irq.c:439]: (error) Uninitialized
>   variable: hwirq
> 
> Simple fix, remove the redundant increment.

This looks more or less the same as the previous patch you sent? The one which
has been in my next branch for 11 days?

cheers
