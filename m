Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1E4D2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 13:06:10 +1000 (EST)
Message-ID: <1346900756.19098.20.camel@pasglop>
Subject: Re: [powerpc:next 11/29]
 arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration
 of function 'memblock_end_of_DRAM'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 06 Sep 2012 13:05:56 +1000
In-Reply-To: <20120906030326.GA16800@localhost>
References: <20120906022003.GB16076@localhost>
 <1346899471.19098.14.camel@pasglop> <1346899754.19098.15.camel@pasglop>
 <20120906030326.GA16800@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-06 at 11:03 +0800, Fengguang Wu wrote:
> 
> No problem. Sorry I didn't know that. Will test HEAD commits only for
> this branch in future.

Actually, I'd rather you continue doing bisection tests, it's good, I
can whack on the head of people who submit stuff with breakage.

In fact, next time around, I'll try to be more pro-active at putting
things in my rebase-able test branch so you get a chance to run your
tests on it and we can find & fix these before it hits next. I'll let
you know when I do it.

In the meantime, maybe just blacklist those commits ?

Cheers,
Ben.
