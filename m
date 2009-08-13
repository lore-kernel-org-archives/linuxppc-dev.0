Return-Path: <Catalin.Marinas@arm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7A7D5B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 01:40:55 +1000 (EST)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[193.131.176.58]) by ozlabs.org (Postfix) with ESMTP id C0E4DDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 01:40:53 +1000 (EST)
Subject: Re: [PATCH] Add kmemleak annotations to lmb.c
From: Catalin Marinas <catalin.marinas@arm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <e846103b117cc36798b1f352ed526d600fd88e16.1250132460.git.michael@ellerman.id.au>
References: <e846103b117cc36798b1f352ed526d600fd88e16.1250132460.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 16:40:41 +0100
Message-Id: <1250178041.14019.34.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 13:01 +1000, Michael Ellerman wrote:
> We don't actually want kmemleak to track the lmb allocations, so we
> pass min_count as 0. However telling kmemleak about lmb allocations
> allows it to scan that memory for pointers to other memory that is
> tracked by kmemleak, ie. slab allocations etc.

Looks alright to me (though I haven't tested it). You can add a
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
