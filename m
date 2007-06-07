Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE8AFDDEC8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 12:56:41 +1000 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Fix recognition of whitespace characters 
In-Reply-To: Your message of "Thu, 07 Jun 2007 12:07:35 +1000."
	<20070607020735.GD24230@localhost.localdomain>
References: <20070607020735.GD24230@localhost.localdomain> 
Date: Wed, 06 Jun 2007 21:56:36 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Hw8Au-0003a8-61@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Mark Lacas <lacas@synapse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> At present, the lexer in dtc recognizes only space, tab and newline as
> whitespace characters.  This is broken; in particular this means that
> dtc will get syntax errors on files with DOS-style (CR-LF) newlines.

Doctor, it hurts when I use DOS. :-)

> This patch fixes the problem, using flex's built-int [:space:]
> character class.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> Jon, please apply.

Applied.

Thanks,
jdl
