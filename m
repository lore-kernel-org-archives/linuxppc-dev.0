Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 28957B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 22:40:05 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F6C4DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 22:40:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HChoaj018336
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 08:43:50 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HCdiu8206726
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 08:39:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HCapab005661
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 08:36:51 -0400
Date: Mon, 17 Aug 2009 08:39:38 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Poll: Rebasing of powerpc-next
Message-ID: <20090817123938.GA8710@zod.rchland.ibm.com>
References: <1250374817.24143.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250374817.24143.71.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 16, 2009 at 08:20:17AM +1000, Benjamin Herrenschmidt wrote:
>Hi !
>
>I'd like to rebase powerpc-next ... a few bugs have been found that it
>would be nice to fix in the original patch rather than introducing a
>bisection breakage, and Kumar also just noticed a potentially misleading
>error in a commit message from his tree.
>
>So who is not ok with me doing that tomorrow or tuesday ?

That's fine with me.  I have a few pending patches to pull in, and another
to send out myself.  I'll do that after the rebase.

josh
