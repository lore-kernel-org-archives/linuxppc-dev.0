Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E952B7209
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 23:11:50 +1000 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] dtc: Remove unused check variable 
In-reply-to: <20110715135732.GC4368@yookeroo.fritz.box> 
References: <20110628124709.GC10237@zod.rchland.ibm.com>
	<20110715135732.GC4368@yookeroo.fritz.box>
Date: Sun, 17 Jul 2011 07:36:36 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1QiQaK-0002sh-A3@jdl.com>
Cc: linuxppc-dev@lists.ozlabs.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, Jun 28, 2011 at 08:47:09AM -0400, Josh Boyer wrote:
> > Commit 376ab6f2 removed the old style check functionality from DTC,
> > however the check option and variable were not removed.  This leads to
> > build failures when -Werror=unused-but-set-variable is specified:
> > 
> > 	dtc.c: In function 'main':
> > 	dtc.c:102:17: error: variable 'check' set but not used [-Werror=unused-but-set-variable]
> > 	cc1: all warnings being treated as errors
> > 	make: *** [dtc.o] Error 1
> > 	make: *** Waiting for unfinished jobs....
> > 
> > Remove the check variable.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
