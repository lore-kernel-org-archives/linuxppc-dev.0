Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04E52DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:28:00 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][DTC] Add an option to pad the blob that is generated 
In-Reply-To: Your message of "Wed, 28 Nov 2007 10:21:12 CST."
	<Pine.LNX.4.64.0711281020240.5095@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711281020240.5095@blarg.am.freescale.net> 
Date: Tue, 04 Dec 2007 07:27:56 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzXoa-0005Um-SZ@jdl.com>
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
> There are times when we need extra space in the blob and just want
> to have it added on w/o know the exact size to make it.
> 
> The padding and min size options are mutually exclusive.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied.

Thanks,
jdl
