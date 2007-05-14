Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2C21DDEE3
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 17:59:06 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 17:59:00 +1000
Message-Id: <1179129541.32247.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Note that it depends on a patch I posted earlier today to add a
> prototype for __vunmap to include/linux/vmalloc.h

Actually it's me being stupid, I can just use vunmap() without
underscores :-) Oh well, you can still review the patch, I'll add that
fix to future versions.

Ben.
