Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BF63DDF13
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 23:35:27 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Remove bogus errors from check_chosen. 
In-Reply-To: Your message of "Thu, 22 Mar 2007 11:11:09 CDT."
	<20070322161109.GA20512@ld0162-tx32.am.freescale.net>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net> 
Date: Mon, 26 Mar 2007 08:35:17 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HVpLx-0004Gk-Ip@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Scott Wood mumbled:
> It is not an error for /chosen (or any of its children) to be missing.
> 
> It is not a requirement that the output of dtc be a complete, valid
> device tree, as it may be intended that the dtb be passed through boot
> code that will complete it.  Thus, do not complain.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Applied.

Thanks,
jdl
