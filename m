Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 289E11A0729
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 18:15:56 +1100 (AEDT)
Message-ID: <551B9B2A.10109@ozlabs.org>
Date: Wed, 01 Apr 2015 15:15:54 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Remove the celleb support
References: <1426738520-21905-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1426738520-21905-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> The celleb code has seen no actual development for ~7 years.
> 
> We (maintainers) have no access to test hardware, and it is highly
> likely the code has bit-rotted.
> 
> As far as we're aware the hardware was never widely available, and is
> certainly no longer available, and no one on the list has shown any
> interest in it over the years.
> 
> So remove it. If anyone has one and cares please speak up.

I've never had any spufs-related feedback from celleb platforms either.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
