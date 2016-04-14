Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm1LM4MDzzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 23:12:43 +1000 (AEST)
Message-ID: <1460639562.21066.7.camel@ellerman.id.au>
Subject: Re: [PATCH 3/5] powerpc/livepatch: Add livepatch header
From: Michael Ellerman <mpe@ellerman.id.au>
To: Miroslav Benes <mbenes@suse.cz>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Date: Thu, 14 Apr 2016 23:12:42 +1000
In-Reply-To: <alpine.LNX.2.00.1604141422220.10605@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <1460552003-15409-4-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604141417310.10605@pobox.suse.cz>
 <alpine.LNX.2.00.1604141422220.10605@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-14 at 14:23 +0200, Miroslav Benes wrote:
> On Thu, 14 Apr 2016, Miroslav Benes wrote:
> > On Wed, 13 Apr 2016, Michael Ellerman wrote:
> > > diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> > > new file mode 100644
> > > index 000000000000..ad36e8e34fa1
> > > --- /dev/null
> > > +++ b/arch/powerpc/include/asm/livepatch.h
> > > @@ -0,0 +1,54 @@
...
> > > +#ifndef _ASM_POWERPC_LIVEPATCH_H
> > > +#define _ASM_POWERPC_LIVEPATCH_H
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/ftrace.h>
> > > +
> > > +#ifdef CONFIG_LIVEPATCH
> > 
> > We don't use these guards in our header files since 335e073faacc ("klp: 
> > remove CONFIG_LIVEPATCH dependency from klp headers").
> 
> ...but you're gonna need it in the next patch...

Yeah I know I said at one point those #ifdefs were unneeded, but then it turns
out we did want it on powerpc for other reasons.

cheers
