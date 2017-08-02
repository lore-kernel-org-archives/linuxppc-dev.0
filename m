Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMfj40jxbzDsRL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 14:04:56 +1000 (AEST)
Message-ID: <1501646674.3739.6.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Sergei Shtylyov
 <sergei.shtylyov@cogentembedded.com>, Kumar Gala
 <galak@kernel.crashing.org>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 01 Aug 2017 23:04:34 -0500
In-Reply-To: <87h8xs6hxc.fsf@concordia.ellerman.id.au>
References: <20170729195217.214940504@cogentembedded.com>
 <1501379504.3739.4.camel@buserror.net>
 <87h8xs6hxc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] mpc832x_rdb: fix of_irq_to_resource() error check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-31 at 20:04 +1000, Michael Ellerman wrote:
> Scott Wood <oss@buserror.net> writes:
> 
> > On Sat, 2017-07-29 at 22:52 +0300, Sergei Shtylyov wrote:
> > > of_irq_to_resource() has recently been  fixed to return negative error
> > > #'s
> > > along with 0 in case of failure,  however the Freescale MPC832x RDB
> > > board
> > > code still only regards 0 as as failure indication -- fix it up.
> > > 
> > > Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in
> > > of_irq_to_resource()")
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > 
> > > ---
> > > The patch is against the 'master' branch of Scott Wood's 'linux.git'
> > > repo
> > > (the 'fixes' branch is too much behind).
> > 
> > The master branch is also old.  Those branches are only used when needed
> > to
> > apply patches; I don't update them just to sync up.  If they're older than
> > what's in Michael's or Linus's tree (as they almost always are), then use
> > those instead.
> > 
> > Not that I expect it to make a difference to this patch...
> 
> Do you want me to grab this as a fix for 4.13 ?

Sure:
Acked-by: Scott Wood <oss@buserror.net>

-Scott
