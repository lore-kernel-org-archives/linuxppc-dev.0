Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wywxX31M1zDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:33:52 +1000 (AEST)
Date: Thu, 29 Jun 2017 18:33:47 +0800
From: Eryu Guan <eguan@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, liwan@redhat.com
Subject: Re: [v4.12-rc1 regression] mount ext4 fs results in kernel crash on
 PPC64le host
Message-ID: <20170629103347.GR23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <87h8yz9ji8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h8yz9ji8.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 08:27:11PM +1000, Michael Ellerman wrote:
> Eryu Guan <eguan@redhat.com> writes:
> 
> > Hi all,
> >
> > Li Wang and I are constantly seeing ppc64le hosts crashing due to bad
> > page access. But it's not reproducing on every ppc64le host we've
> > tested, but it usually happened in filesystem testings.
> 
> <snip>
> 
> > And I've confirmed that reverting above commit 'resolves' the crash.
> 
> Do you mean ~v4.12-rc7 with that commit reverted still triggers the
> crash?

Correct. I also confirmed that reverting it when it was HEAD also fixed
the crash.

Thanks,
Eryu
