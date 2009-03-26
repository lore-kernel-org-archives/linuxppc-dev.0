Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9441DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 17:00:08 +1100 (EST)
Subject: Re: [PATCH] powerpc: Sanitize stack pointer in signal handling code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090325162700.GB2367@yoda.jdub.homelinux.org>
References: <20090325162359.GA2367@yoda.jdub.homelinux.org>
	<20090325162700.GB2367@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Thu, 26 Mar 2009 16:59:46 +1100
Message-Id: <1238047186.25062.824.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Ben, this should look familiar.  It's based on your current -next branch.
> 
> If you agree, I can send it to the -stable team for .27, .28 and .29.

Patch looks good. I'll review more closely tomorrow morning and put it
in my -next branch, which I'll then ask Linux to pull. At this point, we
can have it backported into stable.

Cheers,
Ben.
