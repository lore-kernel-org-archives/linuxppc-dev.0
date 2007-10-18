Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3319DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:22:54 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Thu, 18 Oct 2007 17:20:22 +0400
References: <200710181500.32288.yur@emcraft.com>
	<1192708038.12879.54.camel@pasglop>
In-Reply-To: <1192708038.12879.54.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710181720.22588.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thursday 18 October 2007 15:47, Benjamin Herrenschmidt wrote:
> 
> >  Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
> >  Acked-by: Yuri Tikhonov <yur@emcraft.com>
> 
> Small nit...
> 
> You are posting the patch, thus you should be signing off, not ack'ing.
> 
> Ack'ing means you agree with the patch but you aren't in the handling
> chain for it. In this case, it seems like the author is Pavel and you
> are forwarding it, in wich case, you -are- in the handling chain and
> should should sign it off.
> 
> Best would be for Pavel (if he is indeed the author) to submit it
> himself though.

  Thanks for the explanations. Will keep this in mind in the future.

> 
> Ben.

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
