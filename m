Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPLKJ1H0FzDvtr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 11:52:52 +1100 (AEDT)
Message-ID: <1479948766.5547.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh/of: use builtin_platform_driver
From: Russell Currey <ruscur@russell.cc>
To: Geliang Tang <geliangtang@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Nov 2016 11:52:46 +1100
In-Reply-To: <5f8659707d87126507e163dcada64c6f8923933e.1479913108.git.geliangtang@gmail.com>
References: <5f8659707d87126507e163dcada64c6f8923933e.1479913108.git.geliangtang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 22:58 +0800, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---

Acked-by: Russell Currey <ruscur@russell.cc>
