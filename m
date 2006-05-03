Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 01CBF67A3A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 May 2006 22:43:34 +1000 (EST)
Date: Wed, 3 May 2006 05:43:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Message-Id: <20060503054312.b3978297.akpm@osdl.org>
In-Reply-To: <20060427125726.GK32127@wohnheim.fh-wedel.de>
References: <4450B378.9000705@de.ibm.com>
	<20060427125726.GK32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: schickhj@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	RAISCH@de.ibm.com, HNGUYEN@de.ibm.com, MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Apr 2006 14:57:26 +0200
J=F6rn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Don't expect much cheer and rejoicing over this.  I suspect that akpm
> or Linus will either want the 17 patches merged into one or have a
> patchset where every single patch leaves the kernel in a working
> state, including working eHCA driver.

It doesn't matter in this case.  The "don't break the build at any stage of
a series" preference exists because it's extremely irritating to hit a
won't-build in the middle of a git-bisect operation.

But anybody who is bisection searching for a bug won't want to enable a
brand-new driver in their config, so no problems.
