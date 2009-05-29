Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 804DBDDFC7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 17:39:29 +1000 (EST)
Subject: Re: [PATCH] powerpc ptrace block-step
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20090529073213.B7227FC2BD@magilla.sf.frob.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1243573429.17903.30.camel@pasglop>
	<20090529073213.B7227FC2BD@magilla.sf.frob.com>
Content-Type: text/plain
Date: Fri, 29 May 2009 17:39:21 +1000
Message-Id: <1243582761.17903.38.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-29 at 00:32 -0700, Roland McGrath wrote:
> Thanks!  I'm very glad to finally see this ironed out by someone who
> actually knows about powerpc innards.

yeah, it's been on my todo list for some time... decided that it stayed
rotting for too long. We also did a little test program to exercise wich
is how I discovered the subtle difference between BookE and server.

Any comment about my approach of making BookE "look like" server by
sticking a single step in there ? IE. Is the semantic of stopping on the
-target- of the branch what userspace expects ?

Cheers,
Ben.
