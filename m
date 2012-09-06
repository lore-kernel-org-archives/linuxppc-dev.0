Return-Path: <fengguang.wu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 4D4B82C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 13:18:04 +1000 (EST)
Date: Thu, 6 Sep 2012 11:18:01 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [powerpc:next 11/29]
 arch/powerpc/platforms/pseries/iommu.c:1064:2: error: implicit declaration
 of function 'memblock_end_of_DRAM'
Message-ID: <20120906031801.GA16913@localhost>
References: <20120906022003.GB16076@localhost>
 <1346899471.19098.14.camel@pasglop>
 <1346899754.19098.15.camel@pasglop>
 <20120906030326.GA16800@localhost>
 <1346900756.19098.20.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346900756.19098.20.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2012 at 01:05:56PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2012-09-06 at 11:03 +0800, Fengguang Wu wrote:
> > 
> > No problem. Sorry I didn't know that. Will test HEAD commits only for
> > this branch in future.
> 
> Actually, I'd rather you continue doing bisection tests, it's good, I
> can whack on the head of people who submit stuff with breakage.

OK.

> In fact, next time around, I'll try to be more pro-active at putting
> things in my rebase-able test branch so you get a chance to run your
> tests on it and we can find & fix these before it hits next. I'll let
> you know when I do it.

That would be great.

> In the meantime, maybe just blacklist those commits ?

Should not necessary if I understand you right. FYI the build system
will auto ignore all notified build errors and skip compiled commits.


Thanks,
Fengguang
