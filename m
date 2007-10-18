Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5534BDDF6C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:28:12 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Thu, 18 Oct 2007 17:25:42 +0400
References: <200710181108.19413.yur@emcraft.com>
	<20071018070139.339e2efb@weaponx.rchland.ibm.com>
	<1192709532.12879.61.camel@pasglop>
In-Reply-To: <1192709532.12879.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710181725.42378.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 18 October 2007 16:12, Benjamin Herrenschmidt wrote:

> > I always reserve the right to change my mind.  If something makes sense
> > and the code is decent enough then it might very well be acceptable.
> > Requiring a modified binutils makes me a bit nervous though.
> 
>  From a kernel point of view, I totally don't care about the modified
> binutils to build userspace as long as it's not required to build the
> kernel and that option is not enabled by default (and explicitely
> documented as having that requirement).
> 
> If it is necessary for building the kernel, then I'm a bit cooler about
> the whole thing indeed, the max page size needs to be added at least as
> a command line or linker script param so a different build of binutils
> isn't needed.

 No, 256K-page-sized kernel is being built using the standard binutils. Modifications
to them are necessary for user-space applications only. And the libraries as well.

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
