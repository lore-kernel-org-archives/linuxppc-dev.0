Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1A39DDF36
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 23:41:55 +1000 (EST)
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism. 
In-Reply-To: Your message of "Fri, 23 Mar 2007 15:18:41 CDT."
	<1174681120.32390.82.camel@ld0161-tx32>
References: <1174681120.32390.82.camel@ld0161-tx32> 
Date: Mon, 26 Mar 2007 08:41:52 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HVpSK-0004M3-6D@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jon Loeliger mumbled:
> 
> Keeps track of open files in a stack, and assigns
> a filenum to source positions for each lexical token.
> Modified error reporting to show source file as well.
> No policy on file directory basis has been decided.
> Still handles stdin.
> 
> Tested on all arch/powerpc/boot/dts DTS files
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Applied.

Er, thanks,
jdl
