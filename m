Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E71FB6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 08:04:18 +1000 (EST)
Date: Tue, 03 Apr 2012 18:02:12 -0400 (EDT)
Message-Id: <20120403.180212.1644422418766062447.davem@davemloft.net>
To: kaffeemonster@googlemail.com
Subject: Re: [REGRESSION][PATCH V4 1/3] bpf jit: Make the
 filter.c::__load_pointer helper non-static for the jits
From: David Miller <davem@davemloft.net>
In-Reply-To: <4F75CC63.10405@googlemail.com>
References: <4F75CA89.4010709@googlemail.com> <4F75CC63.10405@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jan Seiffert <kaffeemonster@googlemail.com>
Date: Fri, 30 Mar 2012 17:08:19 +0200

> The function is renamed to make it a little more clear what it does.
> It is not added to any .h because it is not for general consumption, only for
> bpf internal use (and so by the jits).
> 
> Signed-of-by: Jan Seiffert <kaffeemonster@googlemail.com>

Applied but with comment formatting fixed up:

> +/*
> + * No hurry in this branch
> + *
> + * Exported for the bpf jit load helper.
> + */

Like this:

> +/* No hurry in this branch
> + *
> + * Exported for the bpf jit load helper.
> + */
