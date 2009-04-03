Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 80022DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 13:00:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc ptrace block-step
In-Reply-To: Josh Boyer's message of  Thursday, 2 April 2009 21:13:27 -0400
	<20090403011327.GA16881@zod.rchland.ibm.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1238650016.17330.193.camel@pasglop>
	<20090403004450.F2166FC3AB@magilla.sf.frob.com>
	<20090403011327.GA16881@zod.rchland.ibm.com>
Message-Id: <20090403015956.A2244FC3AB@magilla.sf.frob.com>
Date: Thu,  2 Apr 2009 18:59:56 -0700 (PDT)
Cc: utrace-devel@redhat.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't think having it working for BookE is really a requirement before this
> gets in though.  If we can get it working with minimal effort for ppc64, that
> would help get systemtap and related things functioning correctly there.

Sure, just conditionalize arch_has_block_step() however is correct for that
and put in what already works earlier rather than later, I'd say.  Then
users of the excluded chips can come forward when they care, and you can
worry about it then if you don't happen to get to it first.


Thanks,
Roland
