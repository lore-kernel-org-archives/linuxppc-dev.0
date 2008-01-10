Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BC2EDE070
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 01:16:48 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH 2/2] Preserve scanner state when /include/ing. 
In-Reply-To: Your message of "Mon, 07 Jan 2008 14:27:51 CST."
	<20080107202751.GB17782@ld0162-tx32.am.freescale.net>
References: <20080107202751.GB17782@ld0162-tx32.am.freescale.net> 
Date: Thu, 10 Jan 2008 08:16:42 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JCyD4-00071o-37@jdl.com>
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
> This allows /include/s to work when in non-default states,
> such as PROPNODECHAR.
> 
> We may want to use state stacks to get rid of BEGIN_DEFAULT() altogether...
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Hmmm..  With this applied, I get the usual warning:

        CHK version_gen.h
         CC dtc-lexer.lex.o
    dtc-lexer.lex.c:1901: warning: 'yy_top_state' defined but not used

*grumble*

Applied.

jdl
