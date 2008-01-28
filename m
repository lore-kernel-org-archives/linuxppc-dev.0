Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F31FDDF2F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:29:14 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 86xx: Remove unused IRQ defines 
In-Reply-To: Your message of "Mon, 28 Jan 2008 09:20:00 CST."
	<Pine.LNX.4.64.0801280919410.22627@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801280919410.22627@blarg.am.freescale.net> 
Date: Mon, 28 Jan 2008 09:29:09 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JJVv3-0005WM-Ik@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> 86xx uses the flat device tree for all its needs so we dont need explicit
> IRQ info. Its not clear why this code existed since 86xx never existed in
> arch/ppc.

Sorry, my fault.

If you Sign-off-by: that patch, a maintainer can apply it! :-)

jdl
