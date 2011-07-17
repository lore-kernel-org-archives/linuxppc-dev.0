Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8D55B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 23:11:47 +1000 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] dtc: Remove unused variable in flat_read_mem_reserve 
In-reply-to: <20110715135755.GD4368@yookeroo.fritz.box> 
References: <20110628134711.GF10237@zod.rchland.ibm.com>
	<20110715135755.GD4368@yookeroo.fritz.box>
Date: Sun, 17 Jul 2011 07:36:55 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1QiQad-0002sx-6m@jdl.com>
Cc: linuxppc-dev@lists.ozlabs.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, Jun 28, 2011 at 09:47:11AM -0400, Josh Boyer wrote:
> > The *p variable is declared and used to save inb->ptr, however p is
> > later never used.  This has been the case since commit 6c0f3676 and can
> > lead to build failures with -Werror=unused-but-set-variable:
> > 
> > 	flattree.c: In function 'flat_read_mem_reserve':
> > 	flattree.c:700:14: error: variable 'p' set but not used [-Werror=unused-but-set-variable]
> > 	cc1: all warnings being treated as errors
> > 	make: *** [flattree.o] Error 1
> > 
> > Remove the variable.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
