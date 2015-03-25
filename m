Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E9241A0BED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:26:13 +1100 (AEDT)
Message-ID: <1427261159.6468.70.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Remove the celleb support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 25 Mar 2015 16:25:59 +1100
In-Reply-To: <1426738520-21905-1-git-send-email-mpe@ellerman.id.au>
References: <1426738520-21905-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-19 at 15:15 +1100, Michael Ellerman wrote:
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
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.
