Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6A2DDDECD
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 02:22:31 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Remove \n from yyerror() call. 
In-Reply-To: Your message of "Fri, 04 Jan 2008 15:10:47 CST."
	<20080104211047.GC28991@ld0162-tx32.am.freescale.net>
References: <20080104211047.GC28991@ld0162-tx32.am.freescale.net> 
Date: Mon, 07 Jan 2008 09:22:27 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JBto4-0005Cl-0E@jdl.com>
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
> The \n is provided by yyerror().
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Applied.

Thanks,
jdl
