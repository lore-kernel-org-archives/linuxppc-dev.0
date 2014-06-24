Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF9B21A017E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 12:35:00 +1000 (EST)
Message-ID: <1403577290.4587.148.camel@pasglop>
Subject: Re: [PATCH 04/24] powerpc: check/return actual error on sysfs
 functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 24 Jun 2014 12:34:50 +1000
In-Reply-To: <20140617192334.GA4628@kroah.com>
References: <53A0512D.1090909@oracle.com> <20140617192334.GA4628@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeff Liu <jeff.liu@oracle.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-17 at 12:23 -0700, Greg KH wrote:
> On Tue, Jun 17, 2014 at 10:31:09PM +0800, Jeff Liu wrote:
> > From: Jie Liu <jeff.liu@oracle.com>
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Signed-off-by: Jie Liu <jeff.liu@oracle.com>
> > ---
> >  arch/powerpc/platforms/powernv/opal-dump.c | 2 +-
> >  arch/powerpc/platforms/powernv/opal-elog.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Ben and Paul, please do not take this patch, it is incorrect.

Thanks, ignored :-)

Cheers,
Ben.
